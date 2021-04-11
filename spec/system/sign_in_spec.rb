require "rails_helper"

RSpec.describe "Sign In" do
  context "as regular user" do
    it "can sign in successfully" do
      user = create(:user)
      visit signin_path
      fill_in "email_or_username", with: user.username
      fill_in "password", with: user.password

      click_button "Sign In"

      expect(page).to have_content "testUser@test.com"
    end
  end

  context "as an admin user" do
    it "can sign in successfully" do
      user = create(:admin_user)
      visit signin_path
      fill_in "email_or_username", with: user.username
      fill_in "password", with: user.password

      click_button "Sign In"

      expect(page).to have_content "adminUser@test.com"
    end
  end
end
