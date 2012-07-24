class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :year
      t.integer :spots
      t.string :email
      t.integer :totalCost
      t.integer :registrationCost
      t.date :lastPaymentDate
      t.boolean :openRegistration

      t.timestamps
    end
  end
end
