class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :trend_id
      t.string :fundamental
      t.decimal :profit
      t.integer :user_id
    end
  end
end
