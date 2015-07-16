class ChangeColumnsAtTrends < ActiveRecord::Migration
  def up
    remove_column :trends, :fundamental
    remove_column :trends, :profit
    add_column :trends, :user_id, :integer
    add_column :trends, :obsoleted_at, :datetime
  end

  def down
    remove_column :trends, :obsoleted_at
    remove_column :trends, :user_id
    add_column :trends, :profit, :decimal
    add_column :trends, :fundamental, :string
  end
end
