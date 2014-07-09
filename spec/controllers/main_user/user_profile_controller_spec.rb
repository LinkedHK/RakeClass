require 'rails_helper'

RSpec.describe MainUser::UserProfileController, :type => :controller do


  context "Profile edit Pages accessibility " do
    before(:each) do
      create_user_with_images
    end
   it " Access profile edit page" do
     get :index
     expect(response).to have_http_status(200)
   end

  end



end