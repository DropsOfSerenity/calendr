Rails.application.routes.draw do
  devise_for :users
  root "application#index"

  post 'pusher/auth'

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do
      resources :homework
      resources :subject
    end
  end

  get "*path" => "application#index"
end
