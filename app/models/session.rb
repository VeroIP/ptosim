class Session < ApplicationRecord
  belongs_to :user

  def otp_verified?
    otp_verified_at.present?
  end

  def mark_otp_verified!
    update!(otp_verified_at: Time.current)
  end

  def fully_authenticated?
    return true unless user.two_factor_required?
    otp_verified?
  end
end
