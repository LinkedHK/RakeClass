class AddUserUid < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE `slap_development`.`slap_users`
          CHANGE COLUMN `uid` `uid` BIGINT UNSIGNED NULL DEFAULT NULL ;
        SQL
      end
    end
  end
end
