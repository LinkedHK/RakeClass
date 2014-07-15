class SlapUser < ActiveRecord::Base
    include ValidationFields
    include Concerns::SlapUserMain
    include Concerns::UserProfileConcern
    attr_accessor :via_ouath
    attr_accessor :signup
    attr_accessor :user_id
    attr_accessor :back_url
    attr_accessor :avatar
    has_many :user_images, as: :imageable,class_name: 'UserImages' ,:dependent => :destroy
    accepts_nested_attributes_for :user_images
    with_options unless: :via_ouath do |u|
      u.validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 } ,format: USERNAME_REGEX
      u.validates :password,:confirmation => true,:length => { :in => 6..20 }
      u.before_save :encrypt_password
    end
    validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX  ,:length => {maximum: 254}
    validates_length_of :last_name, :maximum => 20
    validates_length_of :first_name, :maximum => 20

end


