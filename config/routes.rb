Rails.application.routes.draw do
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

  #Breeds
  get "/breeds", to: "breeds#view", as: "breeds"
  post "/breeds", to: "breeds#create"
  get "/breeds/new", to: "breeds#new", as: "new_breeds"
  get "/breeds/:id", to: "breeds#show", as: "breed"
  get "/breeds/edit", to: "breeds#edit", as: "edit_breeds"

  # The * says if it doesn't recognise a path it will go to not_found html.
  get "*path", to: "pages#not_found"
end
