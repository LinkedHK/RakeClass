class SlapProfile < ActiveRecord::Base
  include ValidationFields
  self.table_name = 'slap_users'
  has_many :user_imageses, :class_name => 'UserImages'
  validates :email, :format => EMAIL_REGEX,:length => { :maximum => 50 }
  validates_length_of :last_name, :maximum => 20
  validates_length_of :first_name, :maximum => 20

  def self.get_user_profile(user_id)
    @user = SlapUser.where(:id => user_id).select(:first_name,:last_name,:id).first
  end
  def self.update_profile_image(user_id,update_image_params)
    @user = SlapUser.get_profile(user_id)
    @img =  @user.user_images.where(:imageable_id => @user.id,:profile_image => 1).first
    unless @img
      @img = UserImages.new
    end
    @img.update_attributes(update_image_params)
   return @img
  end

end