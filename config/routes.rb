Rails.application.routes.draw do
  get 'tickets/create'
  resources :events do 
    resources :tickets
  end

  get "retire", to: "users#retire"

  root to: 'welcome#index'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :users
  
  match "*path" , to: "application#error404", via: :all
end
