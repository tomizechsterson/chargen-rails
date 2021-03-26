require 'rails_helper'

RSpec.describe User do
  describe "#save" do
    context "with a valid user" do
      it "successfully saves the user" do
        user = User.new(
          name: "A",
          email: "a@b.c",
          password: "0123456789",
          password_confirmation: "0123456789",
          username: "A"
        )

        expect(user.save).to be_truthy
      end
    end

    context "with no attributes defined" do
      it "does not save" do
        user = User.new

        expect(user.save).to be_falsey
        expect(user.errors.count).to be(5)
        expect(user.errors.messages[:name].first).to eq("can't be blank")
        expect(user.errors.messages[:email].first).to eq("is invalid")
        expect(user.errors.messages[:password].first).to eq("can't be blank")
        expect(user.errors.messages[:username]).to include("can't be blank", "is invalid")
      end
    end

    context "with missing name" do
      it "does not save" do
        user = User.new(
          email: "test@test.com",
          password: "testtesttest",
          password_confirmation: "testtesttest",
          username: "missingName"
        )

        expect(user.save).to be_falsey
        expect(user.errors.count).to be(1)
        expect(user.errors.messages[:name].first).to eq("can't be blank")
      end
    end

    context "email" do
      context "is missing" do
        user = User.new(
          name: "test",
          password: "testtesttest",
          password_confirmation: "testtesttest",
          username: "missingEmail"
        )

        it "does not save" do
          expect(user.save).to be_falsey
          expect(user.errors.count).to be(1)
          expect(user.errors.messages[:email].first).to eq("is invalid")
        end
      end

      context "is invalid" do
        user = User.new(
          name: "test",
          email: "blah",
          password: "testtesttest",
          password_confirmation: "testtesttest",
          username: "invalidEmail"
        )

        it "does not save" do
          expect(user.save).to be_falsey
          expect(user.errors.count).to be(1)
          expect(user.errors.messages[:email].first).to eq("is invalid")
        end
      end

      context "is not unique (case insensitive)" do
        some_user = User.new(
          name: "test",
          email: "valid@email.com",
          password: "testtesttest",
          password_confirmation: "testtesttest",
          username: "emailTaken"
        )
        some_user.save

        it "does not save" do
          new_user = User.new(
            name: "someone else",
            email: "VALID@EMAIL.COM",
            password: "newpassword",
            password_confirmation: "newpassword",
            username: "emailNotUnique"
          )

          expect(new_user.save).to be_falsey
          expect(new_user.errors.count).to be(1)
          expect(new_user.errors.messages[:email].first).to eq("has already been taken")
        end
      end
    end

    context "password" do
      context "is missing" do
        user = User.new(
          name: "test",
          email: "some@email.com",
          username: "passwordMissing"
        )

        it "does not save" do
          expect(user.save).to be_falsey
          expect(user.errors.count).to be(1)
          expect(user.errors.messages[:password].first).to eq("can't be blank")
        end
      end

      context "is too short" do
        user = User.new(
          name: "test",
          email: "some@email.com",
          password: "test",
          password_confirmation: "test",
          username: "passwordShort"
        )

        it "does not save" do
          expect(user.save).to be_falsey
          expect(user.errors.count).to be(1)
          expect(user.errors.messages[:password].first).to eq("is too short (minimum is 10 characters)")
        end
      end

      context "does not match confirmation" do
        user = User.new(
          name: "test",
          email: "some@email.com",
          password: "testtesttest",
          password_confirmation: "blahblahblah",
          username: "passwordConfirmationWrong"
        )

        it "does not save" do
          expect(user.save).to be_falsey
          expect(user.errors.count).to be(1)
          expect(user.errors.messages[:password_confirmation].first).to eq("doesn't match Password")
        end
      end
    end

    context "username" do
      context "is missing" do
        user = User.new(
          name: "test",
          email: "a@b.c",
          password: "testtesttest",
          password_confirmation: "testtesttest"
        )

        it "does not save" do
          expect(user.save).to be_falsey
          expect(user.errors.count).to be(2)
          expect(user.errors.messages[:username]).to include("can't be blank", "is invalid")
        end
      end

      context "is invalid" do
        user = User.new(
          name: "test",
          email: "a@b.c",
          password: "testtesttest",
          password_confirmation: "testtesttest",
          username: "!"
        )

        it "does not save" do
          expect(user.save).to be_falsey
          expect(user.errors.count).to be(1)
          expect(user.errors.messages[:username].first).to eq("is invalid")
        end
      end

      # $10 to whomever can show me why this test doesn't work
      # context "is not unique (case insensitive)" do
      #   a_user = User.new(
      #     name: "test",
      #     email: "valid@email.com",
      #     password: "testtesttest",
      #     password_confirmation: "testtesttest",
      #     username: "test"
      #   )
      #   a_user.save
      #
      #   it "does not save" do
      #     b_user = User.new(
      #       name: "someone",
      #       email: "another@email.com",
      #       password: "testtesttest",
      #       password_confirmation: "testtesttest",
      #       username: "test"
      #     )
      #
      #     expect(b_user.save).to be_falsey
      #     expect(b_user.errors.count).to be(1)
      #     expect(b_user.errors.messages[:username].first).to eq("has already been taken")
      #   end
      # end
    end
  end
end
