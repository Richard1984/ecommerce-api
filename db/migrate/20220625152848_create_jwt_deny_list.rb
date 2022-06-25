class CreateJwtDenyList < ActiveRecord::Migration[7.0]
  def change
    create_table :jwt_deny_list do |t|
      t.string :jti, null: false
      t.datetime :exp, null: false
    end
    add_index :jwt_deny_list, :jti
  end
end