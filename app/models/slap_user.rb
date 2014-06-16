require 'digest/sha1'
class SlapUser < ActiveRecord::Base
  include ValidationFields

 self.table_name = 'slap_users'

  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 } ,format: USERNAME_REGEX
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX  ,:length => { :in => 5..20 }
  validates :password,:confirmation => true

  validates_length_of :password, :in => 6..20
  validates_length_of :last_name, :maximum => 20
  validates_length_of :first_name, :maximum => 20
  before_save :encrypt_password



  def encrypt_password
    self.password = Digest::SHA2.hexdigest(self.password)
  end

end




