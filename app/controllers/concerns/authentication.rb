module Authentication
  extend ActiveSupport::Concern

  SESSION_COOKIE = :session_id

  included do
    before_action :resume_session
    before_action :require_authentication
    helper_method :authenticated?, :current_user, :current_session
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private

  # ---- Callback gates ----------------------------------------------------

  def require_authentication
    return if authenticated?

    store_return_location
    redirect_to sign_in_redirect_path, alert: "Please sign in to continue."
  end

  # Send unauthenticated users to the appropriate sign-in URL based on where
  # they were trying to go. Console paths route to the hidden /console/sign_in;
  # everything else routes to the public /login.
  def sign_in_redirect_path
    request.path.start_with?("/console") ? sign_in_path : login_path
  end

  def require_admin
    return if current_user&.role_admin?
    redirect_to post_sign_in_path_for(current_user), alert: "You don't have access to that."
  end

  # Where to send a user right after they finish signing in (or accepting an
  # invitation). Staff go to the console; members have no dedicated area yet,
  # so they land on the public site.
  def post_sign_in_path_for(user)
    return root_path if user.nil?
    (user.role_admin? || user.role_sales?) ? console_root_path : dashboard_path
  end

  # ---- Session lifecycle -------------------------------------------------

  def resume_session
    Current.session = find_session_from_cookie
  end

  def find_session_from_cookie
    session_id = cookies.signed[SESSION_COOKIE]
    Session.find_by(id: session_id) if session_id
  end

  def start_new_session_for(user)
    session = user.sessions.create!(
      ip_address: request.remote_ip,
      user_agent: request.user_agent
    )
    Current.session = session
    cookies.signed.permanent[SESSION_COOKIE] = {
      value: session.id,
      httponly: true,
      secure: Rails.env.production?,
      same_site: :lax
    }
    session
  end

  def terminate_session
    current_session&.destroy
    cookies.delete(SESSION_COOKIE)
    Current.session = nil
  end

  # ---- Return-to routing -------------------------------------------------

  def store_return_location
    return unless request.get? || request.head?
    return if request.path.start_with?("/console/sign_in", "/console/two_factor", "/invitations", "/login")
    session[:return_to] = request.fullpath
  end

  def consume_return_location(default:)
    session.delete(:return_to) || default
  end

  # ---- Helpers -----------------------------------------------------------

  def authenticated?
    current_session.present? && current_session.fully_authenticated?
  end

  def signed_in_but_unverified?
    current_session.present? && !current_session.fully_authenticated?
  end

  def current_session
    Current.session
  end

  def current_user
    Current.user
  end
end
