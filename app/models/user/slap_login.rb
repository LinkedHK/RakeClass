  class SlapLogin < ActiveRecord::Base
    include ValidationFields
    attr_accessor :email,:password,:mobile_auth,:inst_id,:mobile_token
    self.table_name = 'slap_users'
    validates :email, :presence => true, :format => EMAIL_REGEX,:length => { :maximum => 50 }
    validates :password,:presence => true,:length => { :in => 6..20 }



  end
