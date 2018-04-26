Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, except: [:new, :edit], defaults: { format: 'json' } do
    namespace :v1 do
      namespace :admin do
        resources :roles
        resources :departments
        resources :users
      end
      resources :tickets do
        resources :comments
        get :statuses
        collection do
          get :assigned
          get :ticket_option
        end
      end

      resources :leaves, only: [:create,:index]

    end
  end
end
