class AddIndexesToRequestFlood < ActiveRecord::Migration
  def change
    add_index(:request_flood,:client_ip)
    add_index(:request_flood,:action)
    add_index(:request_flood,:expiration_date)
  end
end
