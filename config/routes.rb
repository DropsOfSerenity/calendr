Rails.application.routes.draw do
  devise_for :users
  root "application#index"

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do

    end
  end

  get "*path" => "application#index"
end
