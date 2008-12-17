class AddProbationaryStatusToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :on_probation, :boolean
  end

  def self.down
    remove :groups, :on_probation
  end
end
