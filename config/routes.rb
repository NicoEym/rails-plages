Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users

  resources :calendars do
    resources :beaches do
      resources :teams do
        resources :team_lifeguards
      end
    end
  end
end
