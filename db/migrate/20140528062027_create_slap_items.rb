class CreateSlapItems < ActiveRecord::Migration
  def change
    create_table :slap_items do |t|
     t.string :item_title,limit: 255
      t.text :item_description
      t.timestamps
    end
  end
end
