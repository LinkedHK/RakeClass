class AddDefaultValueToAttemptNumber < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
       ALTER TABLE `slap_development`.`request_flood`
        CHANGE COLUMN `attempt` `attempt` INT(11) NULL DEFAULT 1 ;
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE `slap_development`.`request_flood`
          CHANGE COLUMN `attempt` `attempt` INT(11) NULL DEFAULT NULL;
        SQL
      end
    end
  end
end
