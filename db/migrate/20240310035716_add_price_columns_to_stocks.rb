class AddPriceColumnsToStocks < ActiveRecord::Migration[7.1]
  def change
    add_column :stocks, :high_price, :decimal
    add_column :stocks, :low_price, :decimal
    add_column :stocks, :opening_price, :decimal
  end
end
