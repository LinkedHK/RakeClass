class ChangeImagesTable < ActiveRecord::Migration
  def up
    drop_table :user_images
  end

  def down
    create_table :user_images do |t|
      t.integer :imageable_id
      t.string  :imageable_type
      t.string :remote_image
      t.attachment :avatar
      t.timestamps
    end
    add_index :user_images, :imageable_id
  end
end
