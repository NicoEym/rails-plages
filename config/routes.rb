Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users

  resources :teams, only: [:index]
  resources :beaches

  # resources :seasons do
    resources :calendars do
      resources :beaches do
        resources :teams, only: [:new, :create, :edit, :update, :destroy] do
          resources :team_lifeguards
        end
      end
    end
  # end
end
