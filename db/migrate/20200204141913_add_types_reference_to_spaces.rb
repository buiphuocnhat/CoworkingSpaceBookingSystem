class AddTypesReferenceToSpaces < ActiveRecord::Migration[5.2]
  def change
    add_reference :spaces, :type, foreign_key: true
  end
end
