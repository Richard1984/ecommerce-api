class CreateShop < ActiveRecord::Migration[7.0]
  def change
    create_table :shops do |t|
      t.integer :singleton_guard
      t.string :name, default: ""
      t.string :surname, default: ""
      t.string :social_reason, default: ""
      t.string :vat_number, default: ""
      t.string :address, default: ""
      t.string :sector, default: ""

      t.timestamps
    end
    add_index(:shops, :singleton_guard, unique: true)
  end
end
