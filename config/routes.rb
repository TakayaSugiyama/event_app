Rails.application.routes.draw do
  resources :events
  root to: 'welcome#index'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  resource :users
end
