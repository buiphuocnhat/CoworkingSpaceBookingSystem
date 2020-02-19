class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.decimal :per_month
      t.decimal :per_day
      t.decimal :per_hour
      t.references :space, foreign_key: true

      t.timestamps
    end
  end
end
