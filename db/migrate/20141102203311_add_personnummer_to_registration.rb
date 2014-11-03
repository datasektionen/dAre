class AddPersonnummerToRegistration < ActiveRecord::Migration
  def change
  	add_column :registrations, :personnummer, :string
  end
end
