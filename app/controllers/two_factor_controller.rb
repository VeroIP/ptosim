require "rqrcode"

class TwoFactorController < ApplicationController
  layout "console_auth"

  # 2FA endpoints require a valid session but not a fully-verified one.
  allow_unauthenticated_access
  before_action :require_signed_in_but_unverified

  def enroll
    if @user.otp_secret.blank?
      @user.generate_otp_secret!
    end
    @qr_svg = qr_svg_for(@user.otp_provisioning_uri)
  end

  def confirm_enrollment
    if @user.verify_otp(params[:code])
      @user.enable_two_factor!
      current_session.mark_otp_verified!
      redirect_to consume_return_location(default: post_sign_in_path_for(@user)),
                  notice: "Two-factor authentication enabled."
    else
      flash.now[:alert] = "That code didn't match. Try again."
      @qr_svg = qr_svg_for(@user.otp_provisioning_uri)
      render :enroll, status: :unprocessable_entity
    end
  end

  def challenge
  end

  def verify
    if @user.verify_otp(params[:code])
      current_session.mark_otp_verified!
      redirect_to consume_return_location(default: post_sign_in_path_for(@user))
    else
      flash.now[:alert] = "That code didn't match. Try again."
      render :challenge, status: :unprocessable_entity
    end
  end

  def cancel
    terminate_session
    redirect_to sign_in_path, notice: "Signed out."
  end

  private

  def require_signed_in_but_unverified
    if authenticated?
      redirect_to console_root_path
      return
    end

    unless signed_in_but_unverified?
      redirect_to sign_in_path, alert: "Please sign in first."
      return
    end

    @user = current_session.user
  end

  def qr_svg_for(uri)
    RQRCode::QRCode.new(uri).as_svg(
      module_size: 5,
      standalone: true,
      use_path: true,
      color: "222"
    ).html_safe
  end
end
