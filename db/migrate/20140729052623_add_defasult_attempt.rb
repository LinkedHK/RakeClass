class AddDefasultAttempt < ActiveRecord::Migration
  def change
    change_column(:request_flood,:attempt,:integer,{:default =>  1})
  end
end
