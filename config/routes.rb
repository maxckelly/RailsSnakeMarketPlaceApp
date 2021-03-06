Rails.application.routes.draw do
  devise_for :users
  get "/", to: "pages#home", as: "root"


  # Listings
  get "/listings", to: "listings#index", as: "listings"
  post "/listings", to: "listings#create"
  get "/listings/new", to: "listings#new", as: "new_listing"
  get "/listings/:id", to: "listings#show", as: "listing"
  put "/listings/:id", to: "listings#update"
  patch "/listings/:id", to: "listings#update"
  delete "/listings/:id", to: "listings#destroy"
  get "/listings/:id/edit", to: "listings#edit", as: "edit_listing"

  # Stripe/Payments Routes
  get "/payments/success", to: "payments#success"
  post "payments/webhook", to: "payments#webhook"

  # Breeds
  get "/breeds", to: "breeds#view", as: "breeds"
  post "/breeds", to: "breeds#create"
  get "/breeds/new", to: "breeds#new", as: "new_breeds"
  get "/breeds/:id", to: "breeds#show", as: "breed"
  get "/breeds/edit", to: "breeds#edit", as: "edit_breeds"
  delete "/breeds/:id", to: "breeds#destroy", as: "delete_breed"

  # The * says if it doesn't recognise a path it will go to not_found html.
  get "*path", to: "pages#not_found", constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
end
