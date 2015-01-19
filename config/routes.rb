Rails.application.routes.draw do
  root "application#index"

  namespace :api, :defaults => {:format => :json} do
    namespace :v1 do

    end
  end

  get "*path" => "application#index"
end
