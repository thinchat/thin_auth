ThinAuth::Application.routes.draw do
  scope '/auth' do
    devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

    root :to => "pages#index"

    namespace :api do
      namespace :v1 do
        resources :users, :only => [:show]
      end
    end
  end
end
