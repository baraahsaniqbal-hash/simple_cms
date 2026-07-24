Rails.application.routes.draw do

  root "universities#index"
  constraints AdminDomainConstraint do

    root to: "universities#index", as: :universities_index
    resources :universities
    resources :subjects

  end

  constraints UniversityDomainConstraint do

    resources :universities, only: [:index, :show]
    root to: "universities#show", as: :universities_show

    resources :subjects, only: [:index] do
      member do
        post :add
        delete :remove
      end
    end

  end
  
  # root 'universities#index'
  # get '/public/show/:permalink', to: 'public#show', as: :public_show
 
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
  }

  # devise_scope :user do
  #   get 'join/:slug', to: "users/registrations#new", as: :join
  # end

  resources :pages
  resources :sections
  match ':controller(/:action(/:id))', via: :all
  #get 'demo/index', to: 'demo#index', as: 'index_demo'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
