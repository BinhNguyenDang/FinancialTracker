class Stock < ApplicationRecord
    def self.new_lookup(ticker_symbol)
      price_data = Polygon.get_closing_price(ticker_symbol)
      name = Polygon.get_company_name(ticker_symbol)
  
      if price_data
        new(
          ticker: ticker_symbol,
          name: name,
          last_price: price_data[:closing_price],
          high_price: price_data[:high_price],
          low_price: price_data[:low_price],
          opening_price: price_data[:opening_price],
          volume: price_data[:volume],
          vwap: price_data[:vwap]
        )
      else
        nil
      end
    end
  end
  
