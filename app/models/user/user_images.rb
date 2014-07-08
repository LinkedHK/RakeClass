  class UserImages < ActiveRecord::Base
    belongs_to :imageable ,polymorphic: true
    has_attached_file :avatar,
                      :styles => { :medium => "300x300>", :thumb => "125x125>" },
                      :path => ":rails_root/public/images/users/:id/:style/:hash.:extension",
                      :default_url => "/images/normal/missing.jpg",
                      :url => "/images/users/:id/:style/:hash.:extension",
                      :hash_secret => "EWRWerrew234UTY"

    validates_attachment :avatar, :content_type =>  { :content_type => ["image/jpeg", "image/gif", "image/png"] },
                                      :size => { :in => 0..5.megabytes }



  end

