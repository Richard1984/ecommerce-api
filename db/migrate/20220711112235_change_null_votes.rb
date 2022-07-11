class ChangeNullVotes < ActiveRecord::Migration[7.0]
  def change
    change_column_null :votes, :likes, false
  end
end
