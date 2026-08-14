require "rotp"

class User < ApplicationRecord
  INVITE_VALID_FOR = 7.days

  has_secure_password validations: false

  belongs_to :organization, optional: true
  has_many :sessions, dependent: :destroy

  enum :role, { member: 0, sales: 1, admin: 2 }, prefix: :role

  normalizes :email_address, with: ->(v) { v.to_s.strip.downcase.presence }

  validates :email_address, presence: true, uniqueness: true,
                            format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 12 }, allow_nil: true
  validate  :staff_users_have_no_organization
  validate  :members_have_an_organization

  # ---- Invitation --------------------------------------------------------

  def self.generate_invite_token
    SecureRandom.urlsafe_base64(32)
  end

  def issue_invitation!
    update!(
      password_digest: nil,
      invite_token: self.class.generate_invite_token,
      invite_sent_at: Time.current,
      invite_accepted_at: nil
    )
  end

  def invitation_pending?
    invite_token.present? && invite_accepted_at.nil?
  end

  def invitation_expired?
    invite_sent_at.blank? || invite_sent_at < INVITE_VALID_FOR.ago
  end

  def accept_invitation!(password:)
    self.password = password
    self.invite_token = nil
    self.invite_accepted_at = Time.current
    save!
  end

  # ---- TOTP 2FA ----------------------------------------------------------

  def two_factor_required?
    return false unless Rails.application.config.require_two_factor
    role_admin? || role_sales?
  end

  def two_factor_enrolled?
    otp_enabled_at.present? && otp_secret.present?
  end

  def generate_otp_secret!
    update!(otp_secret: ROTP::Base32.random)
  end

  def otp_provisioning_uri(issuer: "PTO Sim")
    ROTP::TOTP.new(otp_secret, issuer: issuer).provisioning_uri(email_address)
  end

  def verify_otp(code)
    return false if otp_secret.blank? || code.blank?
    ROTP::TOTP.new(otp_secret).verify(code.to_s.gsub(/\s+/, ""), drift_behind: 15).present?
  end

  def enable_two_factor!
    update!(otp_enabled_at: Time.current)
  end

  private

  def staff_users_have_no_organization
    return unless role_admin? || role_sales?
    return if organization_id.nil?
    errors.add(:organization, "must be empty for admin and sales users")
  end

  def members_have_an_organization
    return unless role_member?
    return if organization_id.present?
    errors.add(:organization, "is required for member users")
  end
end
