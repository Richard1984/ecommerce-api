class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :stars
      t.text :comments
      t.belongs_to :product, null: false, foreign_key: true # uguale a reference
      t.belongs_to :user, null: false, foreign_key: true # uguale a reference

      t.timestamps
    end
  end
end
