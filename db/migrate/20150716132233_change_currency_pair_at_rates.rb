class ChangeCurrencyPairAtRates < ActiveRecord::Migration
  def up
    remove_column :rates, :currency_pair
    add_column :rates, :currency_pair_id, :integer
  end

  def down
    remove_column :rates, :currency_pair_id
    add_column :rates, :currency_pair, :string
  end
end
