class CreateListsEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :lists_entries do |t|
      t.references :list, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
