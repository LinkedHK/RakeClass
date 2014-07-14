  class UserImages < ActiveRecord::Base
    belongs_to :imageable ,polymorphic: true
    has_attached_file :avatar,
                      :styles => { :medium => "300x300>",
                                   :thumb => "125x125>", :post_thumb => "40x40>" },
                      :path => ":rails_root/public/images/users/:id/:style/:hash.:extension",
                      :default_url => "/images/normal/missing.jpg",
                      :url => "/images/users/:id/:style/:hash.:extension",
                      :hash_secret => "EWRWerrew234UTY"

    validates_attachment :avatar, :content_type =>  { :content_type => ["image/jpeg", "image/gif", "image/png"] },
                                      :size => { :in => 0..5.megabytes }

    before_create :randomize_file_name
    before_update :randomize_file_name

   private
    def randomize_file_name
      if avatar_file_name
        extension = File.extname(avatar_file_name).downcase
        self.avatar.instance_write(:file_name, "#{SecureRandom.uuid}#{extension}")
      end
    end
  end

