require 'rspec'
require 'rails_helper'

describe User::SlapLogin do
  before(:each) do
  end

  it "expects  login to be valid" do
    FactoryGirl.create(:slap_user)
    user_login =  FactoryGirl.build(:user_login).attributes
    result = User::SlapLogin.auth_by_email(user_login['email'],user_login['password'])
    expect(result).not_to be_nil
  end
  it "expects account to be not found" do
  user =  FactoryGirl.build(:user_login_email_invalid).attributes
  result = User::SlapLogin.auth_by_email(user['email'],user['password'])
    expect(result).to be_nil
  end

end