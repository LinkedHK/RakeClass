class DropIndexExpDateFlood < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
ALTER TABLE `slap_development`.`request_flood`
DROP INDEX `index_request_flood_expiration_date` ;

        SQL
      end
      dir.down do
          execute <<-SQL
        ALTER TABLE `slap_development`.`request_flood`
        ADD INDEX `index_request_flood_expiration_date` (`expiration_date` ASC);
      SQL

      end
    end
  end
end
