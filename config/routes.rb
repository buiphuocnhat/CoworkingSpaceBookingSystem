Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    get "/about", to: "static_pages#about"
    get "/contact", to: "static_pages#contact"
    root "pages#index"
    get  "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :users
    resources :account_activations, only: :edit
    get "/search", to: "pages#index"
    get "/filter", to: "pages#filter"
    get "/space_book", to: "space_books#show"
    resources :bookings
    resources :payments
  end
end
