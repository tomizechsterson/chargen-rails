require 'rails_helper'

RSpec.describe "/characters" do

  let(:valid_attributes) { { name: "test character", user_id: @user_a.id } }
  let(:invalid_attributes) { { name: nil } }

  before do
    @user_a = User.create!(name: "test a", email: "a@b.c", username: "testa", password: "testtesttest", password_confirmation: "testtesttest")
    @user_b = User.create!(name: "test b", email: "b@b.c", username: "testb", password: "testtesttest", password_confirmation: "testtesttest")
    @admin_user = User.create!(name: "admin", email: "admin@b.c", username: "admin", password: "blahblahblah", password_confirmation: "blahblahblah", admin: true)
  end

  describe "GET /index" do
    context "a user with a character is signed in" do
      it "renders a successful response and the character info" do
        Character.create! valid_attributes
        sign_in_test_user(@user_a)

        get characters_url

        expect(response).to be_successful
        expect(response.body).to include("test character")
      end
    end

    context "admin is signed in" do
      it "renders a successful response and displays character info" do
        Character.create! valid_attributes
        sign_in_admin

        get characters_url

        expect(response).to be_successful
        expect(response.body).to include("test character")
      end
    end

    context "nobody is signed in" do
      it "renders a successful response and doesn't display any characters" do
        Character.create! valid_attributes

        get characters_url

        expect(response).to be_successful
        expect(response.body).not_to include("test character")
      end
    end

    context "user with no characters is signed in" do
      it "renders a successful response and doesn't display any characters" do
        sign_in_test_user(@user_b)

        get characters_url

        expect(response).to be_successful
        expect(response.body).not_to include("test character")
      end
    end
  end

  describe "GET /show" do
    context "character's user is signed in" do
      it "renders a successful response" do
        character = Character.create! valid_attributes
        sign_in_test_user(@user_a)

        get character_url(character)

        expect(response).to be_successful
      end
    end

    context "admin is signed in" do
      it "renders a successful response" do
        character = Character.create! valid_attributes
        sign_in_admin

        get character_url(character)

        expect(response).to be_successful
      end
    end

    context "nobody is signed in" do
      it "responds with a 404" do
        character = Character.create! valid_attributes

        expect {
          get character_url(character)
        }.to raise_error(ActionController::RoutingError)
      end
    end

    context "wrong user is signed in" do
      it "responds with a 404" do
        character = Character.create! valid_attributes
        sign_in_test_user(@user_b)

        expect {
          get character_url(character)
        }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe "GET /new" do
    context "when signed in" do
      it "renders a successful response" do
        sign_in_test_user @user_b

        get new_character_url

        expect(response).to be_successful
      end
    end

    context "when not signed in" do
      it "redirects to the sign in page" do
        get new_character_url

        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe "GET /edit" do
    context "character's user is signed in" do
      it "renders a successful response" do
        character = Character.create! valid_attributes
        sign_in_test_user(@user_a)

        get edit_character_url(character)

        expect(response).to be_successful
      end
    end

    context "admin is signed in" do
      it "renders a successful response" do
        character = Character.create! valid_attributes
        sign_in_admin

        get edit_character_url(character)

        expect(response).to be_successful
      end
    end

    context "nobody is signed in" do
      it "redirects to sign in" do
        character = Character.create! valid_attributes

        get edit_character_url(character)

        expect(response).to redirect_to(new_session_url)
      end
    end

    context "wrong user is signed in" do
      it "renders a 404" do
        character = Character.create! valid_attributes
        sign_in_test_user(@user_b)

        expect {
          get edit_character_url(character)
        }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Character" do
        sign_in_test_user(@user_a)

        expect {
          post characters_url, params: { character: valid_attributes }
        }.to change(Character, :count).by(1)
      end

      it "redirects to the created character" do
        sign_in_test_user(@user_a)

        post characters_url, params: { character: valid_attributes }

        expect(response).to redirect_to(character_url(Character.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Character" do
        expect {
          post characters_url, params: { character: invalid_attributes }
        }.to change(Character, :count).by(0)
      end

      it "returns a 422 (unprocessable_entity) response" do
        sign_in_test_user @user_a

        post characters_url, params: { character: invalid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "includes 'Name can't be blank' in the response body" do
        sign_in_test_user @user_a

        post characters_url, params: { character: invalid_attributes }

        expect(response.body).to include("Name can&#39;t be blank")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) { { name: "updated name" } }

      it "updates the requested character" do
        character = Character.create! valid_attributes
        sign_in_test_user @user_a

        patch character_url(character), params: { character: new_attributes }
        character.reload

        expect(character.name).to eq("updated name")
      end

      it "redirects to the character" do
        character = Character.create! valid_attributes
        sign_in_test_user @user_a

        patch character_url(character), params: { character: new_attributes }

        character.reload

        expect(response).to redirect_to(character_url(character))
      end
    end

    context "with invalid parameters" do
      before do
        character = Character.create! valid_attributes
        sign_in_test_user @user_a
        patch character_url(character), params: { character: invalid_attributes }
      end

      it "returns a 422 (unprocessable_entity) response" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "includes 'Name can't be blank' in the response body" do
        expect(response.body).to include("Name can&#39;t be blank")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested character" do
      character = Character.create! valid_attributes
      sign_in_test_user @user_a

      expect {
        delete character_url(character)
      }.to change(Character, :count).by(-1)
    end

    it "redirects to the characters list" do
      character = Character.create! valid_attributes
      sign_in_test_user @user_a

      delete character_url(character)

      expect(response).to redirect_to(characters_url)
    end
  end

  private

  def sign_in_test_user(user)
    post session_url(email_or_username: user.email, password: user.password)
  end

  def sign_in_admin
    post session_url(email_or_username: "admin@b.c", password: "blahblahblah")
  end
end
