Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  # namespace :api do
  #   get "/photos" => "photos#index"
  # end

  namespace :api do
    post "/users" => "users#create"    # Create user
    get "/users/:id" => "users#show"   # Show user
    post "/sessions" => "sessions#create"    # Create session
  end

end
