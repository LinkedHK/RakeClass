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

    factory :sign_in_user do
      email "test@example.com"
      password "secret"
      factory :sign_invalid_email  do
        email "mock%example.com"
      end
    end
    factory :user_login do
      email "test@example.com"
      password "secret"
      factory :user_login_email_invalid do
        email "mock@example.com"
      end
      factory :invalid_password  do
        password "test23"
      end
    end

  end
end