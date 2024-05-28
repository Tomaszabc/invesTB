FactoryBot.define do
  factory :user do
    email { "admin@example.com" }
    display_name { "Tomek" }
    password { "password" }
    password_confirmation { "password" }
  end
end
