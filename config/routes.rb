Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "products#index"
  get "/products", to: "products#index"
  get '/products/*name', to: 'products#show', as: 'product'
  post '/products', to: 'products#create'
  put "/products/:id", to: "products#update"
end
