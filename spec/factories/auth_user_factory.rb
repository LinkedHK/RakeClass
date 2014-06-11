FactoryGirl.define do
  factory :slap_user do
    username "test"
    email "test@example.com"
    password "secret"
    password_confirmation "secret"

    factory :invalid_slap_user do
      username  ""
      email "test@example.com"
      password "secret"
      password_confirmation "secret"
    end
  end
end