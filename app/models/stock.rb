class Stock < ApplicationRecord
    def self.new_lookup(ticker_symbol)
        last_price = Polygon.get_closing_price(ticker_symbol)
        name = Polygon.get_company_name(ticker_symbol)

        new(ticker: ticker_symbol, name: name, last_price: last_price)
    end
end
