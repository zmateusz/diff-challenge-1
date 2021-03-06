Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        collection do
          post 'sign_up'
          post 'sign_in'
        end
      end

      resources :groups, only: [:index, :create]
      resources :orders, only: [:index, :create]
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
