require 'httparty'
API_KEY = Rails.application.credentials.polygon[:api_key]
class Polygon
    def self.get_company_name(ticker_symbol)
        req_url = "https://api.polygon.io/v3/reference/tickers/#{ticker_symbol}?apiKey=#{API_KEY}"
        headers = {
          'Content-Type': 'application/json'
        }
        response = HTTParty.get(req_url, headers: headers, format: :plain)
        json = JSON.parse response
    
        json['results']['name']
      end
    
      def self.get_closing_price(ticker_symbol)
        req_url = "https://api.polygon.io/v2/aggs/ticker/#{ticker_symbol}/prev?adjusted=true&apiKey=#{API_KEY}"
        headers = {
          'Content-Type': 'application/json'
        }
        response = HTTParty.get(req_url, headers: headers, format: :plain)
        if response.code == 200
            json = JSON.parse(response.body)
            result = json['results'].first
            if result # Check if result is not nil
              closing_price = result['c'] # Closing price
              high_price = result['h'] # High price
              low_price = result['l'] # Low price
              opening_price = result['o'] # Opening price
              volume = result['v'] # Volume
              vwap = result['vw'] # Volume-weighted average price
              
              return {
                closing_price: closing_price,
                high_price: high_price,
                low_price: low_price,
                opening_price: opening_price,
                volume: volume,
                vwap: vwap
              }
            end
          else
            puts "Failed to retrieve data. HTTP status code: #{response.code}"
          end
        
          nil # Return nil if there's an error or no results
    end
end