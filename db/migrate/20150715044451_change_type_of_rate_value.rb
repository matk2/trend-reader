class ChangeTypeOfRateValue < ActiveRecord::Migration
  def up
    change_column :rates, :value, :decimal
  end

  def down
    change_column :rates, :value, :string
  end
end
