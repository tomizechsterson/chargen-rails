require 'rails_helper'

RSpec.describe "Users" do

  let(:valid_attributes) {{
    name: "test",
    email: "a@b.c",
    password: "testtesttest",
    password_confirmation: "testtesttest"
  }}
  let(:invalid_attributes) {{
    name: "",
    email: "a",
    password: "testtest",
    password_confirmation: "blahblah"
  }}

  describe "GET /index" do
    it "renders a successful response" do
      User.create! valid_attributes
      get users_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      user = User.create! valid_attributes
      get user_url(user)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response "do
      get new_user_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new user" do
        expect {
          post users_url, params: {user: valid_attributes }
        }.to change(User, :count).by 1
      end

      it "redirects to the created user" do
        post users_url, params: { user: valid_attributes }

        expect(response).to redirect_to(user_url(User.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new user" do
        expect {
          post users_url, params: { user: invalid_attributes }
        }.to change(User, :count).by 0
      end

      it "returns a 200 response (to display errors)" do
        post users_url, params: { user: invalid_attributes }

        expect(response).to be_successful
      end

      it "includes expected errors in response body" do
        post users_url, params: { user: invalid_attributes }

        expect(response.body).to include(
                                   "Password confirmation doesn&#39;t match Password",
                                   "Name can&#39;t be blank",
                                   "Email is invalid",
                                   "Password is too short (minimum is 10 characters)"
                                 )
      end
    end
  end
end
