Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end

  # Invitation claim (public, single-use token-gated)
  get   "/invitations/:token/edit", to: "invitations#edit",   as: :edit_invitation
  patch "/invitations/:token",      to: "invitations#update", as: :invitation

  # Public auth URLs — the primary sign-in surface for member users.
  get    "/login",  to: "sessions#new",     as: :login
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  # Staff/sales auth — same controller, aliased under the hidden /console path.
  get    "/console/sign_in",  to: "sessions#new",     as: :sign_in
  post   "/console/sign_in",  to: "sessions#create"
  delete "/console/sign_out", to: "sessions#destroy", as: :sign_out

  # Member dashboard — any authenticated user.
  get "/dashboard", to: "dashboard#show", as: :dashboard

  get    "/console/two_factor/enroll",    to: "two_factor#enroll",             as: :two_factor_enroll
  post   "/console/two_factor/enroll",    to: "two_factor#confirm_enrollment"
  get    "/console/two_factor/challenge", to: "two_factor#challenge",          as: :two_factor_challenge
  post   "/console/two_factor/challenge", to: "two_factor#verify"
  delete "/console/two_factor/cancel",    to: "two_factor#cancel",             as: :two_factor_cancel

  # Console pages (require verified admin session).
  scope "/console", as: :console, module: "console" do
    root "dashboard#index"
    resources :organizations, only: %i[index new create show] do
      resources :users, only: %i[new create show], controller: "organization_users"
    end
    resources :staff, only: %i[index new create show], controller: "staff"
  end

  root "landing#index"
end
