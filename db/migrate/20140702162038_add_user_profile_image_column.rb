class AddUserProfileImageColumn < ActiveRecord::Migration
  def change
    add_column(:user_images,:profile_image,:integer)
  end
end
