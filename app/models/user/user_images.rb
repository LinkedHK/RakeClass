module User
  class UserImages < ActiveRecord::Base
    belongs_to :user_slap_user, :class_name => 'User::SlapUser'
    has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "125x125>" }, :default_url => "/images/:style/missing.png"
    validates_attachment :avatar, :content_type =>  { :content_type => ["image/jpeg", "image/gif", "image/png"] },
                                      :size => { :in => 0..5.megabytes }
  end
end
