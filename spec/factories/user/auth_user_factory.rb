FactoryGirl.define do
  factory :slap_user, :class => SlapUser do
    username "test"
    email "test@example.com"
    password "secret"
    password_confirmation "secret"
    first_name "John"
    last_name "Smith"
    factory :user_with_profile_image do
      after(:create) do |slap_user|
           FactoryGirl.create(:profile_image,imageable: slap_user)
      end
    end
    factory :updated_first_last_name do
      first_name "Michael"
      last_name "Jackson"
    end
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
    #  user_user_imageses URI.parse('http://graph.facebook.com/1234567/picture?type=square')
      factory :omni_facebook_used_email  do
        uid 1234510
      end
    end

  end
end