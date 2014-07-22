class RequestFlood < ActiveRecord::Migration
  def change
    create_table :request_flood do |t|
      t.string :client_ip
      t.string  :action
      t.integer :attempt
      t.datetime :expiration_date
    end
  end
end
