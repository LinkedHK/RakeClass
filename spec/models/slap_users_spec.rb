require 'rspec'
require 'rails_helper'

describe SlapUser do
  describe "creation" do
    context "Valid attributes" do
      it "should be valid"  do
       slap_user =  FactoryGirl.build(:slap_user)
       expect(slap_user).to be_valid
      end
      it "Shouldn't be valid" do
        user =  FactoryGirl.build(:slap_user,username: "")
        expect(user).not_to be_valid
      end
    end
    it "User and email are already used" do
      FactoryGirl.create(:slap_user)
      user = FactoryGirl.build(:slap_user)
      expect(user).not_to be_valid
    end
  end
end