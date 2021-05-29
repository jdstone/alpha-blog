class ChangeOrderOfFirstnameColumn < ActiveRecord::Migration[6.1]
  def change
    # this migration did not seem to make any changes to the database
    change_column :users, :firstname, :string, before: :email
  end
end
