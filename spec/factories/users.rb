FactoryBot.define do
  factory :user do
    email               { "dummy@example.com" }
    crypted_password    { "gigantic-hash" }
    password_salt       { "salty" }
    persistence_token   { "token" }
  end
end
