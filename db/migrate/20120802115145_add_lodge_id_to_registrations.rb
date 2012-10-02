class AddLodgeIdToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :lodge_id, :integer, :null => true
  end
end
