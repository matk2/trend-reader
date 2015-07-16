class CreateCurrencyPairs < ActiveRecord::Migration
  def change
    create_table :currency_pairs do |t|
      t.string :base
      t.string :quote
    end
  end
end
