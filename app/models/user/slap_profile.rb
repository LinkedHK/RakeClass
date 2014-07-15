class SlapProfile < ActiveRecord::Base
  include ValidationFields
  self.table_name = 'slap_users'
  has_one :avatar,->{where profile_image: 1},
          :class_name => 'UserImages', as: :imageable
  belongs_to :slap_user, :class_name => 'SlapUser'
  validates :email, :format => EMAIL_REGEX,:length => { :maximum => 50 } ,presence: false
  validates_length_of :last_name, :maximum => 20
  validates_length_of :first_name, :maximum => 20

  def self.get_uprofile(user_id)
    @user = SlapUser.find(user_id)
    @user.avatar = self.get_profile_image(@user)
    @user
  end

  def self.get_profile_image(user)
    @img = UserImages.where(imageable: user,profile_image: 1).first
    unless @img
      @img = UserImages.new
    end
    @img
  end
  def self.update_profile(user_id,data)
    @user = self.find(user_id)
    @user.update_attributes(data)
    @user
  end
  def self.update_profile_image(user_id,update_image_params)
    @user = self.get_uprofile(user_id)
    @img =  @user.avatar
    unless @img
      @img = UserImages.new
    end
    @img.update_attributes(update_image_params)
   return @img
  end

end