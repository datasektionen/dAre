class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :kth_id
      t.string :firstname
      t.string :surname
      t.string :email
      t.string :mobilephone
      t.string :address
      t.string :postalCode
      t.string :postArea
      t.string :grade
      t.string :allergies
      t.string :comment
      t.boolean :hasPayedRegistration
      t.boolean :hasPayedTotal
      t.boolean :partey
      t.boolean :reserve

      t.timestamps
    end
  end
end
