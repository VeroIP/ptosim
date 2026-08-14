module Console
  class OrganizationsController < BaseController
    before_action :set_organization, only: %i[show]

    def index
      @organizations = Organization.order(:name)
    end

    def new
      @organization = Organization.new
    end

    def create
      @organization = Organization.new(organization_params)

      if @organization.save
        redirect_to console_organization_path(@organization),
                    notice: "Organization created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show
      @members = @organization.users.order(:email_address)
    end

    private

    def set_organization
      @organization = Organization.find(params[:id])
    end

    def organization_params
      params.require(:organization).permit(:name, :slug)
    end
  end
end
