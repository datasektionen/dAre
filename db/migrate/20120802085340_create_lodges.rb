class CreateLodges < ActiveRecord::Migration
  def change
    create_table :lodges do |t|
      t.string :address
      t.integer :max_accommodates

      t.timestamps
    end
  end
end
