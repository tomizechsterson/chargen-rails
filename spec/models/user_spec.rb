require 'rails_helper'

RSpec.describe User do
  context "nothing valid" do
    it "doesn't save" do
      user = User.new

      expect(user.save).to be_falsey
    end
  end
end
