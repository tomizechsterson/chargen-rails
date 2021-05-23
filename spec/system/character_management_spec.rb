require "rails_helper"

RSpec.describe "Character Management" do
  context "a regular user" do
    before do
      @user = create(:user)
    end

    it "can create a new character" do
      sign_in @user

      click_link "Characters"

      click_link "New Character"
      expect(page).to have_content "New Character"

      fill_in "character_name", with: "capybara character"
      click_button "Create Character"

      expect(page).to have_content "Character was successfully created"
    end

    it "can edit a character" do
      sign_in @user

      click_link "Characters"
      click_link "New Character"
      fill_in "character_name", with: "capybara character"
      click_button "Create Character"

      expect(page).to have_content "Character was successfully created"

      click_link "Back"
      expect(page).to have_content "capybara character"

      click_link "Edit"
      expect(page).to have_content "Editing Character"

      fill_in "character_name", with: "edited character"
      click_button "Update Character"
      expect(page).to have_content "Character was successfully updated."
      expect(page).to have_content "edited character"
    end

    it "can delete a character" do
      sign_in @user

      click_link "Characters"
      click_link "New Character"
      fill_in "character_name", with: "capybara character"
      click_button "Create Character"

      expect(page).to have_content "Character was successfully created"

      click_link "Back"
      expect(page).to have_content "capybara character"

      accept_confirm do
        click_link "Delete"
      end

      expect(page).to_not have_content "capybara character"
    end
  end

  private

  def sign_in(user)
    visit signin_path
    fill_in "email_or_username", with: user.username
    fill_in "password", with: user.password

    click_button "Sign In"
    expect(page).to have_content user.email
  end
end
