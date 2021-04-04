require 'rails_helper'

RSpec.describe Character do
  describe "#save" do
    context "with a valid character" do
      it "successfully saves character" do
        c = Character.new(name: "test", user_id: 1)

        expect(c.save).to be_truthy
      end
    end

    context "with no attributes defined" do
      it "does not save" do
        c = Character.new

        expect(c.save).to be_falsey
      end
    end
  end
end
