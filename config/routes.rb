Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :posts, only: [:index, :create, :update, :destroy]
    end
  end
end
