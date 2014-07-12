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
  context  "Profile edit actions test" do
    before(:each) do
      query_log
    end

    it "Should upload a new image file" do
      user_with_image
      file = FactoryGirl.build(:user_images).attributes
      post :update_image,{user_images: file}, format: :json
      expect(response).to have_http_status(200)
      parsed_response = parse_json(response)
      expect(parsed_response['result']).to eq(1)
    end

  end



end