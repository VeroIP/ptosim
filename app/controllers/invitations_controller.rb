class InvitationsController < ApplicationController
  layout "console_auth"

  allow_unauthenticated_access only: %i[edit update]
  before_action :load_user_from_token

  def edit
  end

  def update
    password = params[:password].to_s
    confirmation = params[:password_confirmation].to_s

    if password.length < 12
      flash.now[:alert] = "Password must be at least 12 characters."
      render :edit, status: :unprocessable_entity
      return
    end

    if password != confirmation
      flash.now[:alert] = "Password and confirmation didn't match."
      render :edit, status: :unprocessable_entity
      return
    end

    @user.accept_invitation!(password: password)
    start_new_session_for(@user)

    if @user.two_factor_required?
      redirect_to two_factor_enroll_path, notice: "Password set. One more step — enroll two-factor authentication."
    else
      redirect_to post_sign_in_path_for(@user), notice: "Welcome, #{@user.email_address}. You're signed in."
    end
  end

  private

  def load_user_from_token
    @user = User.find_by(invite_token: params[:token])

    if @user.nil? || !@user.invitation_pending?
      redirect_to sign_in_path, alert: "That invitation isn't valid."
      nil
    elsif @user.invitation_expired?
      redirect_to sign_in_path, alert: "That invitation has expired. Ask an admin for a fresh one."
      nil
    end
  end
end
