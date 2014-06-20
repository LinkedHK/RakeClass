# spec/support/request_helpers.rb
module Requests
  module JsonHelpers
    def parse_json(response)
      @json ||= JSON.parse(response.body)   rescue []
    end
    def create_slap_user_login
      FactoryGirl.create(:slap_user)
      @user_attributes = FactoryGirl.build(:user_login).attributes
    end

  end
end