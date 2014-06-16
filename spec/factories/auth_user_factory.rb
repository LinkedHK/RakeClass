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

      factory :invalid_email  do
        email "mock@example.com"
        password "secret"
      end
      factory :invalid_password  do
        email "mock@example.com"
        password "test23"
      end
    end
    factory :user_login do
      email "test@example.com"
      password "secret"

      factory :user_login_email_invalid do
        email "mock%example.com"
      end
      factory :non_existing_login do
        email "test@test.com"
        password "secret"

        end

    end

  end
end