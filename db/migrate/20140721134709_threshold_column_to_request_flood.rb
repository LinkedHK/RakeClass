class ThresholdColumnToRequestFlood < ActiveRecord::Migration
  def change
    add_column(:request_flood,:threshold,:integer,{:default => 4})
  end
end
