ThinAuth::Application.routes.draw do
    devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }, :path => "auth/users"
    scope '/auth' do
      root :to => "pages#index"
      
    namespace :api do
      namespace :v1 do
        resources :users, :only => [:index]
      end
    end
  end
end
