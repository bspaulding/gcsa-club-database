class RemoveLeaderEmailFromGroups < ActiveRecord::Migration
  def self.up
    remove_column :groups, :leader_email
  end

  def self.down
    add_column :groups, :leader_email, :string
  end
end
