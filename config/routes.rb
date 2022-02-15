Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do

    root "static_pages#home"
    get "/contact", to: "static_pages#contact"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/products", to: "products#index"

    resources :products, only: :show
    namespace :admin do
      root "admin#index"
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
