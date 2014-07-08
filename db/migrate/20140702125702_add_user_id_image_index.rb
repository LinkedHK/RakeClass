class AddUserIdImageIndex < ActiveRecord::Migration
  def change
    add_index(:user_images,:slap_user_id)
  end
end
