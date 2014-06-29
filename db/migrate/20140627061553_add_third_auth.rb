class AddThirdAuth < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE `slap_users`
          CHANGE COLUMN `first_name` `first_name` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
          CHANGE COLUMN `last_name` `last_name` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ;
        SQL
      end
    end
  end
end
