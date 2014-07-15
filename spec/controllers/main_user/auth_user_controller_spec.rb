require 'rails_helper'

RSpec.describe MainUser::AuthUserController, :type => :controller do

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
        expect(session[:user_id]).not_to be_nil
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
        user_attributes=create_slap_user_login
        post :post_login, {slap_login: user_attributes}
        expect redirect_to :root_url
        expect(session[:user_id]).not_to be_nil
      end
      it "Can user signout" do
        session[:user_id]  = 2
        get :logout
        expect(session[:user_id]).to be_nil
        expect redirect_to :root_url
      end
    end
  end


  context "Json Login Action" do
    before(:each) do
      FactoryGirl.create(:slap_user)
      request.env["HTTP_ACCEPT"] = 'application/json'
    end
    it 'Sign in user' do
      user_attributes= FactoryGirl.build(:user_login).attributes
      post :post_login,{slap_login: user_attributes},:format => :json
      resp =  parse_json(response)
      expect(response).to have_http_status(200)
      expect(resp['result']).to eq(1)
      expect(session[:user_id]).not_to be_nil
      expect(resp['info']).to eq(I18n.t(:successful_login))
    end
    it 'Sign in user failure. Invalid email' do
      user_attributes=  FactoryGirl.build(:user_login_email_invalid).attributes
      post :post_login,{slap_login: user_attributes},:format => :json
      resp =  parse_json(response)
      expect(response).to have_http_status(422)
      expect(resp['result']).to eq(0)
    end
    it 'Sign in user failure. Invalid password' do
      user_attributes=  FactoryGirl.build(:invalid_password).attributes
      post :post_login,{slap_login: user_attributes},:format => :json
      resp = parse_json(response)
      expect(response).to have_http_status(422)
      expect(resp['result']).to eq(0)
    end

    it "Can user signout" do
      session[:user_id]  = 2
      get :logout
      resp = parse_json(response)
      expect(session[:user_id]).to be_nil
      expect(resp['result']).to eq(1)
      expect(resp['info']).to eq(I18n.t(:successful_signout))
    end
  end

  context "Signup Action" do
    before(:each) do
      request.env["HTTP_ACCEPT"] = 'application/json'
    end
    it 'Sign up user' do
      user_attributes =  FactoryGirl.build(:slap_user).attributes
      post :post_signup,{slap_user: user_attributes},:format => :json
      resp =  parse_json(response)
      expect(response).to have_http_status(200)
      expect(resp['result']).to eq(1)
    end
    it 'Sign up failure. User email already in use.' do
      FactoryGirl.create(:slap_user)
      user_attributes =  FactoryGirl.build(:slap_user).attributes
      post :post_signup,{slap_user: user_attributes},:format => :json
      resp =  parse_json(response)
      expect(response).to have_http_status(422)
      expect(resp['result']).to eq(0)
    end
  end

  context "Facebook auth provider" do
     before(:each) do
       request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
       #FactoryGirl.create(:omni_facebook)
     end
     it 'User login with used email' do
       FactoryGirl.create(:omni_facebook_used_email)
       expect{
         get :facebook_login,request.env["omniauth.auth"]
       }.to change(SlapUser,:count).by(0)
       expect(response).to have_http_status(200)
     end

    it 'accessibility  facebook auth' do
      expect{
        get :facebook_login,request.env["omniauth.auth"]
      }.to change(SlapUser,:count).by(1)
      expect(response).to have_http_status(200)
    end

  end

end
