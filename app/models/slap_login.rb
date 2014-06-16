class SlapLogin < ActiveRecord::Base
  include ValidationFields
  include UserAuth

  self.table_name = 'slap_users'

  validates :email, :presence => true, :format => EMAIL_REGEX,:length => { :in => 5..20 }
  validates :password,:presence => true,:length => { :in => 6..20 }

  attr_accessor :email,:password
end
