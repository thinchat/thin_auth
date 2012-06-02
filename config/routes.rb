ThinAuth::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  match '/auth' => "pages#index"

  namespace :api do
    namespace :v1 do
      resources :users, :only => [:show]
    end
  end
  
end
