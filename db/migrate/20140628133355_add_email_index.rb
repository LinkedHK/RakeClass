class AddEmailIndex < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE `slap_development`.`slap_users`
          ADD UNIQUE INDEX `index_user_email` (`email` ASC);
        SQL
      end
    end
  end
end
