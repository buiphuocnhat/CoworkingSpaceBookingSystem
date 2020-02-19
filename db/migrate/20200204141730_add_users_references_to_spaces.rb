class AddUsersReferencesToSpaces < ActiveRecord::Migration[5.2]
  def change
    add_reference :spaces, :user, foreign_key: {to_table: :users}
  end
end
