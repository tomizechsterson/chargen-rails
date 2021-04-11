FactoryBot.define do
  factory :user do
    name { "testUser" }
    email { "testUser@test.com" }
    username { "testuser" }
    password { "testtesttest" }
    password_confirmation { "testtesttest" }
    admin { false }

    factory :admin_user do
      name { "adminUser" }
      email { "adminUser@test.com" }
      username { "adminuser" }
      password { "blahblahblah" }
      password_confirmation { "blahblahblah" }
      admin { true }
    end
  end
end
