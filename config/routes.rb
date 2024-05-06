Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }, skip: [:registrations]
  resources :articles, param: :slug do
    member do
      post "like"
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"
end
