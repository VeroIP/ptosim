module Console
  class OrganizationUsersController < BaseController
    before_action :set_organization

    def new
      @user = @organization.users.build
    end

    def create
      @user = @organization.users.build(
        email_address: params.dig(:user, :email_address),
        role: :member
      )
      @user.issue_invitation! if @user.valid?

      if @user.persisted?
        redirect_to console_organization_user_path(@organization, @user),
                    notice: "Invite created. Send the URL below to #{@user.email_address}."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @user = @organization.users.find(params[:id])
      @invite_url = build_invite_url(@user) if @user.invitation_pending?
    end

    private

    def set_organization
      @organization = Organization.find(params[:organization_id])
    end

    def build_invite_url(user)
      edit_invitation_url(user.invite_token, host: request.host_with_port, protocol: request.protocol)
    end
  end
end
