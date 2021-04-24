require 'rails_helper'

RSpec.describe Character do
  context "with all required attributes" do
    it "is valid" do
      test_user = User.new(
        name: "testuser",
        email: "test@test.com",
        password: "blahblahblah",
        password_confirmation: "blahblahblah",
        username: "tester"
      )
      c = Character.new(name: "test", user: test_user)

      expect(c).to be_valid
    end
  end

  context "with no attributes defined" do
    it "is not valid" do
      c = Character.new

      expect(c).to_not be_valid
    end
  end
end
