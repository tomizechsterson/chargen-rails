require 'rails_helper'

RSpec.describe "/users" do

  let(:valid_attributes) {{
    name: "validName",
    email: "a@b.c",
    password: "testtesttest",
    password_confirmation: "testtesttest",
    username: "validUsername"
  }}
  let(:invalid_attributes) {{
    name: "",
    email: "a",
    password: "testtest",
    password_confirmation: "blahblah",
    username: "!"
  }}

  describe "GET /index" do
    it "renders a successful response" do
      User.create! valid_attributes
      sign_in

      get users_url

      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      user = User.create! valid_attributes
      sign_in

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

  describe "GET /edit" do
    it "renders a successful response" do
      user = User.create! valid_attributes
      sign_in

      get edit_user_url(user)

      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new user" do
        expect {
          post users_url, params: { user: valid_attributes }
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

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { { name: "updated name" } }

      it "updates the requested user" do
        user = User.create! valid_attributes
        sign_in

        patch user_url(user), params: { user: new_attributes }
        user.reload

        expect(user.name).to eq("updated name")
      end

      it "redirects to the user" do
        user = User.create! valid_attributes
        sign_in
        patch user_url(user), params: { user: new_attributes }

        user.reload

        expect(response).to redirect_to(user_url(user))
      end
    end

    context "with invalid parameters" do
      before do
        user = User.create! valid_attributes
        sign_in
        patch user_url(user), params: { user: invalid_attributes }
      end

      it "returns a 200 response (to display errors)" do
        expect(response).to be_successful
      end

      it "includes 'Name can't be blank' in the response body" do
        expect(response.body).to include("Name can&#39;t be blank")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      sign_in

      expect {
        delete user_url(user)
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      user = User.create! valid_attributes
      sign_in

      delete user_url(user)

      expect(response).to redirect_to(characters_url)
    end
  end

  private

  def sign_in
    post session_url, params: {
      email_or_username: valid_attributes[:email], password: valid_attributes[:password]
    }
  end
end
