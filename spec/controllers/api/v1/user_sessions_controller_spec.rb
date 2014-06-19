require 'rails_helper'

RSpec.describe  Api::V1::UserSessionsController,:type => :controller  do
   context "Login Action" do
     before(:each) do
       FactoryGirl.create(:slap_user)
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


end
