Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end

  root "landing#index"
end
