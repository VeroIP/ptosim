class SessionsController < ApplicationController
  layout "console_auth"

  allow_unauthenticated_access only: %i[new create destroy]

  def new
  end

  def create
    user = User.find_by(email_address: params[:email_address].to_s.strip.downcase)

    unless user&.authenticate(params[:password].to_s)
      redirect_to sign_in_form_path, alert: "That email and password didn't match."
      return
    end

    if user.invitation_pending?
      redirect_to sign_in_form_path, alert: "You still need to accept your invitation. Check for the invite link."
      return
    end

    start_new_session_for(user)
    redirect_to next_step_after_password
  end

  def destroy
    terminate_session
    redirect_to login_path, notice: "Signed out."
  end

  private

  # Send failed sign-ins back to whichever sign-in URL they came from so the
  # hidden /console/sign_in doesn't leak in the browser bar for public users.
  def sign_in_form_path
    request.path.start_with?("/console") ? sign_in_path : login_path
  end

  def next_step_after_password
    user = current_session.user
    if user.two_factor_required? && !user.two_factor_enrolled?
      two_factor_enroll_path
    elsif user.two_factor_required?
      two_factor_challenge_path
    else
      consume_return_location(default: post_sign_in_path_for(user))
    end
  end
end
