class AddDefaultDateToExpirationDateToRequestFlood < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.down do
        execute <<-SQL
          ALTER TABLE `slap_development`.`request_flood`
          ADD COLUMN `expiration_date` DATETIME NULL AFTER `threshold`,
          ADD INDEX `index_request_flood_expiration_date` (`expiration_date` ASC);
        SQL
      end
    end
  end
end
