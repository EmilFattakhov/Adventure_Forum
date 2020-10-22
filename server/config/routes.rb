Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "welcome#home"
  get("/home", to: "welcome#home")
  get("/about", to: "welcome#about")
  get("/contact_us", to: "welcome#contact_us")
  post("/thank_you", to: "welcome#thank_you")

  #bill splitter
  get "/bill_splitter", to: "bill_splitter#new"
  post "/calculate_split", to: "bill_splitter#create"

  # Session Routes
  resource :session, only: [:new, :create, :destroy]

  # RESTful Product Routes
  #  get '/products/new', to: 'products#new', as: :new_product
  #  post '/products', to: 'products#create'
  #  get '/products/:id', to: 'products#show', as: :product
  #  get '/products', to: 'products#index'
  #  delete '/products/:id', to: 'products#destroy'
  #  get '/products/:id/edit', to: 'products#edit', as: :edit_product
  #  patch '/products/:id', to: 'products#update'

  resources :products do
    resources :reviews, shallow: :true, only: [:create, :destroy] do
      resources :likes, only: [:create, :destroy]
      resources :votes, only: [:create, :update, :destroy]
    end
    resources :favourites, shallow: true, only: [:create, :destroy]
  end

  resources :favourites, only: [:index]

  resources :users, only: [:new, :create]

  namespace :admin do
    resources :dashboard, only: [:index]
  end

  resources :news_articles

  # API routes

  # The namespace method in Rails routes makes it so that
  # your app will automatically look in a directory api,
  # then in a sub directory v1 for QuestionsController

  # The option 'defaults: { format: :json }' will set 'json' as
  # the default response format for all routes contained within
  # the block.

  # The option 'defaults: { format: :json }' will set 'json' as
  # the default response format for all routes contained within
  # the block.

  namespace :api, defaults: { format: :json } do #👈🏻 we can set default response format of the block
    namespace :v1 do
      resources :products, only:[:index,:show,:create, :destroy]
      resource :session, only:[:create, :destroy]
      get 'users/current'
    end
    match "*unmatched_route", to: "application#not_found", via: :all
  end

end
