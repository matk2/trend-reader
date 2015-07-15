class ChangeTypeOfRateValue < ActiveRecord::Migration
  def up
    if connection.adapter_name.downcase == 'postgresql'
      change_column :rates, :value, 'decimal USING CAST(value AS decimal)'
    else
      change_column :rates, :value, :decimal
    end
  end

  def down
    if connection.adapter_name.downcase == 'postgresql'
      change_column :rates, :value, 'string USING CAST(value AS string)'
    else
      change_column :rates, :value, :string
    end
  end
end
