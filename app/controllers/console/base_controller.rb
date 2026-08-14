module Console
  class BaseController < ApplicationController
    layout "console"
    before_action :require_admin
  end
end
