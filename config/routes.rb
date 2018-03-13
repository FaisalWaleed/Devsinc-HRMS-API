Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, except: [:new, :edit], defaults: { format: 'json' } do
    namespace :v1 do
      # resources :groups
      # resources :tickets
      # resources :documents
      # resources :file_uploads
      # resources :leaves
      # resources :companies, only: [] do
      #   collection do
      #     get :current
      #   end
      # end

      namespace :admin do
        resources :departments
        resources :users
      end
    end
  end
end
