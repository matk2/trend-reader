class AddFundamentalToTrends < ActiveRecord::Migration
  def change
    add_column :trends, :fundamental, :string
    add_column :trends, :profit, :decimal
  end
end
