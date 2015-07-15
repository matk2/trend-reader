class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.string :currency_pair
      t.string :value

      t.timestamps null: false
    end
  end
end
