Rails.application.routes.draw do
  resources :wikis 

  devise_for :users, controllers: {sessions: 'users/sessions'}
  resources :users
  get '/about', to: 'welcome#about'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
