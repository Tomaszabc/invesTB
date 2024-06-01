Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }, skip: [:registrations]

  resources :articles, param: :slug do
    resources :comments, only: [:edit, :create, :update, :destroy]
    member do
      post "like"
    end
  end

  root "articles#index"
end
