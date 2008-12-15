class AddAdminTable < ActiveRecord::Migration
  def self.up
    create_table :admin_access do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :admin_access
  end
end