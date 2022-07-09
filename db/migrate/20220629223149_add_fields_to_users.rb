class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :firstname, :string, null: true
    add_column :users, :lastname, :string, null: true
    add_column :users, :country, :string
  end
end
