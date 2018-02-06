Rails.application.routes.draw do

  resources :charges, only: [:new, :create]
  get 'thanks', to: 'charges#thanks', as: 'thanks'

  resources :downgrade
  get 'downgrades', to: 'downgrades#downgrade_account', as: 'downgrade_plan'
  post 'downgrades', to: 'downgrades#downgrade_account', as: 'standard_plan'

  devise_for :users, controllers: {sessions: 'users/sessions'}
  resources :wikis
  # resources :users
  get '/plans', to: 'welcome#plans'
  get '/about', to: 'welcome#about'
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
