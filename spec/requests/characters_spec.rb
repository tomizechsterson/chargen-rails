require 'rails_helper'

RSpec.describe "/characters" do

  let(:valid_attributes) { { name: "test" } }
  let(:invalid_attributes) { { name: nil } }

  describe "GET /index" do
    it "renders a successful response" do
      Character.create! valid_attributes
      get characters_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      character = Character.create! valid_attributes
      get character_url(character)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_character_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      character = Character.create! valid_attributes
      get edit_character_url(character)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Character" do
        expect {
          post characters_url, params: { character: valid_attributes }
        }.to change(Character, :count).by(1)
      end

      it "redirects to the created character" do
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
        post characters_url, params: { character: invalid_attributes }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "includes 'Name can't be blank' in the response body" do
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

        patch character_url(character), params: { character: new_attributes }
        character.reload

        expect(character.name).to eq("updated name")
      end

      it "redirects to the character" do
        character = Character.create! valid_attributes
        patch character_url(character), params: { character: new_attributes }

        character.reload

        expect(response).to redirect_to(character_url(character))
      end
    end

    context "with invalid parameters" do
      before do
        character = Character.create! valid_attributes
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
      expect {
        delete character_url(character)
      }.to change(Character, :count).by(-1)
    end

    it "redirects to the characters list" do
      character = Character.create! valid_attributes
      delete character_url(character)
      expect(response).to redirect_to(characters_url)
    end
  end
end
