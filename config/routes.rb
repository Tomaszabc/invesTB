Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }, skip: [:registrations]

  resources :articles, param: :slug do
    collection do
      get :load_more
    end
    resources :comments, only: [:edit, :create, :update, :destroy, :show]
    member do
      post "like"
    end
  end

  root "articles#index"
end
