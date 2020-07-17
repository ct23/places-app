Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  # namespace :api do
  #   get "/photos" => "photos#index"
  # end

  namespace :api do
    post "/users" => "users#create"        # Create user
    get "/users/:id" => "users#show"       # Show user
    patch "/users/:id" => "users#update"   # Update user
    delete "/users/:id" => "users#destroy" # Destroy user

    post "/sessions" => "sessions#create"    # Create session

    get "/categories" => "categories#index"
    get "/categories/:id" => "categories#show"

    get "/places" => "places#index"
    get "/places/:id" => "places#show"

    get "/favorites" => "favorites#index"
    post "/favorites" => "favorites#create"
    delete "/favorites/:id" => "favorites#destroy"
  end

end
