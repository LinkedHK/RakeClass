module User
  require 'digest/sha1'
  class SlapUser < ActiveRecord::Base
    include ValidationFields
    include Concerns::SlapUserMain
    attr_accessor :via_ouath
    has_many :user_user_imageses, :class_name => 'User::UserImages'

=begin
    has_attached_file :profile_image, :styles => { :medium => "300x300>", :thumb => "120x120>" },
                      :default_url => "/images/profile/:style/missing.png" ,
                      :size => { :maximum => 5.megabytes }
                      self.table_name = 'slap_users'

      u.validates_attachment_content_type :profile_image,
                                          :content_type => { :content_type => ["image/jpeg", "image/gif", "image/png"] }

=end
    with_options unless: :via_ouath do |u|
      u.validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 } ,format: USERNAME_REGEX
      u.validates :password,:confirmation => true,:length => { :in => 6..20 }
      u.before_save :encrypt_password
    end
    validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX  ,:length => {maximum: 254}
    validates_length_of :last_name, :maximum => 20
    validates_length_of :first_name, :maximum => 20
  end



end


