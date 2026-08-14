module Console
  # Manage staff users (admin + sales). Distinct from OrganizationUsersController,
  # which invites members into an organization; staff users belong to no org.
  class StaffController < BaseController
    ALLOWED_ROLES = %w[admin sales].freeze

    def index
      @staff = User.where(role: [ User.roles[:admin], User.roles[:sales] ]).order(:role, :email_address)
    end

    def new
      @user = User.new(role: :sales)
    end

    def create
      email = params.dig(:user, :email_address)
      role  = params.dig(:user, :role)

      unless ALLOWED_ROLES.include?(role)
        @user = User.new(email_address: email)
        @user.errors.add(:role, "must be admin or sales")
        render :new, status: :unprocessable_entity
        return
      end

      @user = User.new(email_address: email, role: role)
      @user.issue_invitation! if @user.valid?

      if @user.persisted?
        redirect_to console_staff_path(@user),
                    notice: "Invite created. Send the URL below to #{@user.email_address}."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @user = User.where(role: [ User.roles[:admin], User.roles[:sales] ]).find(params[:id])
      @invite_url = build_invite_url(@user) if @user.invitation_pending?
    end

    private

    def build_invite_url(user)
      edit_invitation_url(user.invite_token, host: request.host_with_port, protocol: request.protocol)
    end
  end
end
