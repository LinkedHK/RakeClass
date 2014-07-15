require 'rails_helper'

RSpec.describe MainUser::UserProfileController, :type => :controller do

  context "Profile edit Pages accessibility " do
    before(:each) do
      query_log
      user_with_image
    end
   it " Access profile edit page" do
     get :index
     expect(response).to have_http_status(200)
   end
  end
  context "Profile edit actions test" do
    before(:each) do
      query_log
      @user = user_with_image
      request.env["HTTP_ACCEPT"] = 'application/json'
    end
    it "Should upload a new image file" do
      file = FactoryGirl.build(:user_images).attributes
      post :update_image,{user_images: file}, :format => :json
      expect(response).to have_http_status(200)
      parsed_response = parse_json(response)
      expect(parsed_response['result']).to eq(1)
    end

    it "Should change first and last name" do
      updated =  FactoryGirl.build(:updated_first_last_name).attributes
      post :update_profile,{slap_user: updated}, :format => :json
      expect(response).to have_http_status(200)
      parsed_response = parse_json(response)
      profile = SlapProfile.get_uprofile(@user.id)
      expect(profile.first_name).to eq(updated['first_name'])
      expect(profile.last_name).to eq(updated['last_name'])
    end

  end



end