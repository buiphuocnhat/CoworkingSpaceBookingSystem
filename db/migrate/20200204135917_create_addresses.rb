class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :city
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
