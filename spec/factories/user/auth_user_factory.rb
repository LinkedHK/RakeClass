FactoryGirl.define do
  factory :slap_user, :class => User::SlapUser do
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
    factory :omni_facebook  do
      uid 1234567
      provider 'facebook'
      first_name 'Joe'
      last_name 'Bloggs'
      email 'joe@bloggs.com'
      oauth_token 'CAAVQqMmajdwBANSje594N6WI1b2ZCYs9Ym3WA6pSc2mhC1lgsyj4gqWnXC1T1ZC4ZBtZBAji6TsjnZCDDw0YZAgZCHGrJbSZBg7NOhxbsJz9FCPrNk4sLvSoBM5O56Q6XEqoYeU0z4AECxWSiS6nxsiGUZAeLUvg9x6HXRyc8pBb9ZCr1YdCnjHSZAY'
      oauth_expires_at Time.now + 5.days
      factory :omni_facebook_used_email  do
        uid 1234510
      end
    end
  end
end