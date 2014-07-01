class AddUserImageTable < ActiveRecord::Migration
  def change
    create_table :user_images do |t|
      t.belongs_to :slap_user
      t.attachment :avatar
      t.timestamps
    end

    add_index(:user_images,:created_at)
  end
end
