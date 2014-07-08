class SlapProfile < ActiveRecord::Base
  include ValidationFields
  self.table_name = 'slap_users'
  has_many :user_imageses, :class_name => 'UserImages'
  validates :email, :format => EMAIL_REGEX,:length => { :maximum => 50 }
  validates_length_of :last_name, :maximum => 20
  validates_length_of :first_name, :maximum => 20

  def self.get_user_profile(user_id)
    SlapUser.where(:id => user_id)
    .select(:id,:email,:first_name,:last_name).first
    #.joins(:user_user_imageses).where(:user_images => {:slap_user_id => user_id,:profile_image => 1})
  end

end