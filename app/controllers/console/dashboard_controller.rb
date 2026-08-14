module Console
  class DashboardController < BaseController
    def index
      @org_count   = Organization.count
      @user_count  = User.count
      @staff_count = User.where(role: [ User.roles[:admin], User.roles[:sales] ]).count
      @recent_orgs = Organization.order(created_at: :desc).limit(5)
    end
  end
end
