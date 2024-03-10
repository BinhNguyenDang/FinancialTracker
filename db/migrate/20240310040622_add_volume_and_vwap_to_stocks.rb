class AddVolumeAndVwapToStocks < ActiveRecord::Migration[7.1]
  def change
    add_column :stocks, :volume, :decimal
    add_column :stocks, :vwap, :decimal
  end
end
