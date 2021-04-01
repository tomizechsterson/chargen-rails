require 'rails_helper'

RSpec.describe "/sessions" do

  before(:context) do
    @user = User.create!(name: "test session a", email: "sa@b.c", username: "testsessiona", password: "testtesttest", password_confirmation: "testtesttest")
  end
  after(:context) do
    @user.destroy
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_session_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "attempt to sign in with invalid creds" do
      it "stays on the sign in page when username isn't found" do
        post session_url(email_or_username: "wrong", password: "even more wrong")

        expect(response).to be_successful
        expect(response.body).to include("Sign In", "Sign Up")
      end

      it "stays on the sign in page when password is incorrect" do
        post session_url(email_or_username: "sa@b.c", password: "even more wrong")

        expect(response).to be_successful
        expect(response.body).to include("Sign In", "Sign Up")
      end
    end

    context "attempt to sign in with valid creds" do
      it "redirects to user's profile page" do
        post session_url(email_or_username: "testsessiona", password: "testtesttest")

        expect(response).to redirect_to(user_url(@user))
      end
    end

    context "attempt to hit endpoint that requires sign in" do
      it "redirects to sign in and then goes to intended url" do
        get new_character_url
        expect(response).to redirect_to(new_session_url)

        post session_url(email_or_username: "testsessiona", password: "testtesttest")

        expect(response).to redirect_to(new_character_url)
      end
    end
  end

  describe "DELETE /destroy" do
    it "redirects to characters_url" do
      delete session_url
      expect(response).to redirect_to(characters_url)
    end
  end
end
