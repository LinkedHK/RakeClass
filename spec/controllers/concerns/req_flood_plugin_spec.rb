require 'rspec'
require 'rails_helper'

describe  Concerns::Security::ReqFloodPlugin do
  # How to test controller concerns
  #http://stackoverflow.com/questions/22055889/how-to-test-a-controller-concern-in-rails-4

  context "Basic Security tests" do
    controller(ApplicationController) do
      include Concerns::Security::ReqFloodPlugin
      before_action :check_flooder
      def fake_action; redirect_to '/'; end
    end
    before { routes.draw {
      post 'fake_action' => 'anonymous#fake_action'
    } }

    before(:each) do
    query_log
     request.env["HTTP_ACCEPT"] = 'application/json'
    end

    describe "Safe User" do
      before{
        FactoryGirl.create(:request_flood,:action => 'fake_action', :attempt => 1)
        post :fake_action,:format => :json }
      it {
        expect(response).to have_http_status(302)
      }

    end

    describe "Render notification about flood attempt" do
      before{
        FactoryGirl.create(:request_flood,:action => 'fake_action')
        post :fake_action,:format => :json }
      it {
        expect(response).to have_http_status(422)
        resp = parse_json(response)
        expect(resp['result']).to eq(0)
        expect(resp['info']).to eq(I18n.t('security.flooder_detection'))
      }

    end

  end




end