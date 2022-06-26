class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string  :name,             null: false, default: ""
      t.integer :availability,     null: false, default: 0
      t.decimal :price,            null: false, default: 0.0, precision: 6, scale: 2
      t.text    :description,      default: ""

      #t.? :images
      
    end

    add_index       :products, :name,    unique: true
  end
end
