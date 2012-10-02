class AddStaffProjectsJoinTable < ActiveRecord::Migration
  def up
  	create_table :projects_staffs, :id => false do |t|
  		t.integer :project_id
  		t.integer :staff_id
  	end
  end

  def down
  end
end
