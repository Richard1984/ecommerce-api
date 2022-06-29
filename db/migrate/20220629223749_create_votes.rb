class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.bool :likes, null: true # user likes / doesn't like the review

      t.timestamps
    end

    add_reference   :votes, :review, null: false, foreign_key: true
    add_reference   :votes, :user, null: false, foreign_key: true
  end
end
