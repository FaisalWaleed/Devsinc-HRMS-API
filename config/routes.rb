Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth', controllers: {
      sessions: "api/v1/sessions",
      confirmations: "api/v1/confirmations",
      passwords: "api/v1/passwords",
      token_validations: "api/v1/token_validations",
      registrations: "api/v1/registrations"

  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, except: [:new, :edit], defaults: { format: 'json' } do
    namespace :v1 do
      namespace :admin do
        resources :roles do
          member do
            post :allow_permission
            post :revoke_permission
          end
          get :assignable_users
          post :add_users
          post :remove_user
        end
        resources :departments
        resources :users do
          post :restore_user
        end

      end


      resources :tickets do
        resources :comments
        member do
          get :statuses
        end
        collection do
          get :assigned
          get :ticket_option
          get :all_tickets
        end
      end

      resources :leaves, only: [:create, :index] do
        member do
          get :get_user_leaves
        end
        collection do
          get :leave_approvals
          get :user_leaves_history
          get :all_leaves
        end
      end

      resources :leave_statuses, only: [:create, :index]
      resources :permissions, only: [:index] do
        collection do
          get :get_permissions_obj
        end
      end


    end
  end
end
