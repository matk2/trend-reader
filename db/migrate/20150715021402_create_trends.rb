class CreateTrends < ActiveRecord::Migration
  def change
    create_table :trends do |t|
      t.string :kind
      t.integer :rate_id

      t.timestamps null: false
    end
  end
end
