class AddProjectIdToLodges < ActiveRecord::Migration
  def change
  	add_column :lodges, :project_id, :integer
  end
end
