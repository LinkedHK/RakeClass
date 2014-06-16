require 'rails_helper'

RSpec.describe AuthUserController, :type => :controller do


  describe "Pages accessibility" do
    it "accessibility login page" do
      get :login
      expect(response).to have_http_status(200)
    end
    it "accessibility signup page" do
      get :signup
      expect(response).to have_http_status(200)
    end
  end
  describe "Actions functionality" do
    describe "sign_up action tests" do
      it "Sign up user" do
        user_attributes =  FactoryGirl.build(:slap_user).attributes
        expect{
          post :post_signup, {slap_user: user_attributes }
        }.to change(SlapUser,:count).by(1)
        assigns(session[:id])
        expect(response).to redirect_to root_url
      end
      it "Fail to sign up" do
        user_attributes =  FactoryGirl.build(:invalid_slap_user).attributes
        expect{
          post :post_signup, {slap_user: user_attributes }
        }.to change(SlapUser,:count).by(0)
        expect render_template :signup
      end
    end
    describe "login action tests" do
      it "Sign in user" do
        FactoryGirl.create(:slap_user)
        user_attributes=  FactoryGirl.build(:user_login).attributes
          post :post_login, {slap_login: user_attributes}
          expect redirect_to root_url
          assigns(:notice)
          assigns(session[:user_id])

      end

    end

  end

end
