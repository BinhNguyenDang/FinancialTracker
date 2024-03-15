class Stock < ApplicationRecord
    has_many :user_stocks
    has_many :users, through: :user_stocks

    validates :ticker, :name, presence: true

    def self.new_lookup(ticker_symbol)
      begin
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
      rescue => e
        puts "An error occurred while retrieving stock data: #{e.message}"
        nil
      end
    end
  end
