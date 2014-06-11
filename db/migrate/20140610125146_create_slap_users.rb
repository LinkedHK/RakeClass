class CreateSlapUsers < ActiveRecord::Migration
  def change
    change_table :slap_users do |t|
      add_index(:slap_users,[:created_at,:updated_at])
    end
  end
end
