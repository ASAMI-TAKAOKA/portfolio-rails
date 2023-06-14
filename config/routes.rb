Rails.application.routes.draw do
  # devise_for :users

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      # mount_devise_token_auth_for 'User', at: 'auth' ←使用をやめる
      
      # auth_token_controller
      resources :auth_token, only:[:create] do
        post :refresh, on: :collection
        delete :destroy, on: :collection
      end
      resources :posts, only: [:index, :create, :show, :update, :destroy]
      resources :categories, only: [:index, :create, :update, :destroy]
      get 'get_category/children', to: 'posts#get_category_children', defaults: { format: 'json' }
      get 'get_category/grandchildren', to: 'posts#get_category_grandchildren', defaults: { format: 'json' }
    end
  end
end
