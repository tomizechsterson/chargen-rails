require 'rails_helper'

RSpec.describe Character do
  context "nothing valid" do
    it "doesn't save" do
      c = Character.new

      expect(c.save).to be_falsey
    end
  end
end
