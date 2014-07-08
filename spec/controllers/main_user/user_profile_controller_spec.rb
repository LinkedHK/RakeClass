require 'rails_helper'

RSpec.describe MainUser::UserProfileController, :type => :controller do

  context "Profile edit Pages accessibility " do
   it " Access profile edit page" do
     auth_user
     get :index
     expect(response).to have_http_status(200)
   end

  end



end