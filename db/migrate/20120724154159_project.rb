class Project < ActiveRecord::Migration
  def change
  	add_index :projects, :year, :unique => true
  end
end
