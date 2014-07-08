class CreateImagesTable < ActiveRecord::Migration
  def change

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
