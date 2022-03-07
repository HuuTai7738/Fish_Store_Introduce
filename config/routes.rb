Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do

    root "static_pages#home"
    devise_for :users
    get "/contact", to: "static_pages#contact"
    get "/products", to: "products#index"
    get "/carts", to: "carts#index"
    post "/add_to_cart", to: "carts#create", as: "add_to_cart"
    delete "/remove_from_cart/:id", to: "carts#destroy", as: "remove_from_cart"
    post "/update_cart", to: "carts#update"
    get "/list_orders", to: "orders#index"
    get "/checkout", to: "orders#new"
    patch "/cancel/:id", to: "orders#update", as: "cancel"

    as :user do
      get "/login", to: "devise/sessions#new"
      post "/login", to: "devise/sessions#create"
      delete "/logout", to: "devise/sessions#destroy"
      get "/signup", to: "devise/registrations#new"
    end

    resources :orders, only: :create

    resources :products, only: :show
    namespace :admin do
      root "categories#index"
      resources :categories
      resources :products
      resources :users, only: :index
      resources :orders, only: %i(index show update)
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
