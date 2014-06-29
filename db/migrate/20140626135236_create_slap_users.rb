class CreateSlapUsers < ActiveRecord::Migration
  def change
    add_index(:slap_users,[:oauth_expires_at])
    add_index(:slap_users,[:uid],:unique => true)
    reversible do |dir|
      dir.up do
        execute <<-SQL
           ALTER TABLE `slap_users`
            CHANGE COLUMN `uid` `uid` INT UNSIGNED NULL DEFAULT NULL ,
            CHANGE COLUMN `provider` `provider` VARCHAR(255) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL ,
            ADD UNIQUE INDEX `uid_UNIQUE` (`uid` ASC);
        SQL
      end
    end
  end
end
