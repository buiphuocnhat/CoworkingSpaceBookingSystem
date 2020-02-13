class AddSpacePricesReferenceToSpaces < ActiveRecord::Migration[5.2]
  def change
    add_reference :spaces, :space_price, foreign_key: true
  end
end
