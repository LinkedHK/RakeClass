class AddedMonileUserData < ActiveRecord::Migration
  def change
    add_column(:slap_users,:inst_id,:string,{:limit => 255})
    add_column(:slap_users,:mobile_token,:string,{:limit => 255})
  end
end
