require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /users" do
    
    it "creates a user" do
      post "/api/users",
        params: { name: "testuser testerson", email: "test@testy.com", password: "pass", password_confirmation: "pass" }
      expect(response).to have_http_status(201)
    end
    it "should be unprocessable with invalid params" do
      post "/api/users",
        params: { name: "", email: "test@testy.com", password: "pass", password_confirmation: "pass" }
      expect(response).to have_http_status(422)
    end
    it "should be unprocessable with no name specified" do
      post "/api/users",
        params: { name: "", email: "test@testy.com", password: "pass", password_confirmation: "pass" }
      expect(response).to have_http_status(422)
    end
    it "should be unprocessable with non-matching password_confirmation" do
      post "/api/users",
        params: { name: "testuser testerson", email: "test@testy.com", password: "pass1", password_confirmation: "pass" }
      expect(response).to have_http_status(422)
    end
    it "should be unprocessable without a password" do
      post "/api/users",
        params: { name: "testuser testerson", email: "test@testy.com", password: "", password_confirmation: "hi" }
      expect(response).to have_http_status(422)
    end
    it "should be unprocessable without an email" do
      post "/api/users",
        params: { name: "testuser testerson", email: "", password: "pass", password_confirmation: "pass" }
      expect(response).to have_http_status(422)
    end
  end
  describe "GET /users/:id" do
    it "gets information about a user" do
      # Create a user first
      post "/api/users",
        params: { name: "testuser testerson", email: "test@testy.com", password: "pass", password_confirmation: "pass" }
      user = User.find_by(email: "test@testy.com")
      jwt = JWT.encode(
        {
          user_id: user.id, # the data to encode
        },
        Rails.application.credentials.fetch(:secret_key_base), # the secret key
        "HS256" # the encryption algorithm
      )

      get "/api/users/#{user.id}",
        headers: { Authorization: "Bearer #{jwt}" }
      expect(response).to have_http_status(200)
      user = JSON.parse(response.body)
      expect(user["name"]).to eq("testuser testerson")
      expect(user["email"]).to eq("test@testy.com")      
    end
    it "should return unauthorized if the user requested is different than the user logged in" do
      # Create a user first
      post "/api/users",
        params: { name: "testuser testerson", email: "test@testy.com", password: "pass", password_confirmation: "pass" }
      user = User.find_by(email: "test@testy.com")
      jwt = JWT.encode(
        {
          user_id: user.id, # the data to encode
        },
        Rails.application.credentials.fetch(:secret_key_base), # the secret key
        "HS256" # the encryption algorithm
      )
      # Create another user
      post "/api/users",
        params: { name: "testuser2 testerson2", email: "test2@testy.com", password: "pass", password_confirmation: "pass" }
      user2 = User.find_by(email: "test2@testy.com")

      # We are logged in as user, try to get show info about user2
      get "/api/users/#{user2.id}",
        headers: { Authorization: "Bearer #{jwt}" }
      expect(response).to have_http_status(401) # unauthorized
    end
  end
  describe "PATCH /users/:id" do
    it "should update a user's name and email, and/or password" do
      # Create user first
      post "/api/users",
        params: { name: "testuser testerson", email: "test@testy.com", password: "pass", password_confirmation: "pass" }
      user = User.find_by(email: "test@testy.com")
      userid = user.id
      jwt = JWT.encode(
        {
          user_id: userid, # the data to encode
        },
        Rails.application.credentials.fetch(:secret_key_base), # the secret key
        "HS256" # the encryption algorithm
      )

      # Change name and email
      patch "/api/users/#{user.id}",
        params: { name: "newname", email: "newemail@new.com" },
        headers: { Authorization: "Bearer #{jwt}" }
      user = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(user["name"]).to eq("newname")
      expect(user["email"]).to eq("newemail@new.com")

      # Change password
      patch "/api/users/#{userid}",
        params: { password: "newpass", password_confirmation: "newpass" },
        headers: { Authorization: "Bearer #{jwt}" }
      expect(response).to have_http_status(200)
    end
  end
end
