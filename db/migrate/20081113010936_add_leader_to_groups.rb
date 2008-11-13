class AddLeaderToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :leader_name, :string
    add_column :groups, :leader_email, :string
  end

  def self.down
    remove_column :groups, :leader_name
    remove_column :groups, :leader_email
  end
end
