require 'digest/sha1'
class SlapUser < ActiveRecord::Base
  include ValidationFields
  include Concerns::SlapUserMain
  attr_accessor :via_ouath
 self.table_name = 'slap_users'
  with_options unless: :via_ouath do |u|
    u.validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 } ,format: USERNAME_REGEX
    u.validates :password,:confirmation => true,:length => { :in => 6..20 }
    u.before_save :encrypt_password
  end
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX  ,:length => {maximum: 254}
  validates_length_of :last_name, :maximum => 20
  validates_length_of :first_name, :maximum => 20
end




