require 'digest/sha1'
class SlapUser < ActiveRecord::Base
  include ValidationFields
  attr_accessor :saved_user
  after_save :get_saved_user

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

  def create_user
    self.save
    yield
  end
  def get_saved_user
    saved_user = SlapUser.order("created_at").last(1)
  end


  def get_saved_users

  end
end




