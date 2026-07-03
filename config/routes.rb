Rails.application.routes.draw do

  root 'public#index'
  get '/public/show/:permalink', to: 'public#show', as: :public_show
 
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
  }
  resources :subjects
  resources :pages
  resources :sections
  match ':controller(/:action(/:id))', via: :all
  #get 'demo/index', to: 'demo#index', as: 'index_demo'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
