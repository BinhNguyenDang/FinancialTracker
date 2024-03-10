# README

Ruby version
3.2.1

System dependencies
Ruby 3.2.1
Rails 7
NodeJS 18.14.2
npm 9.5.0
yarn 1.22.11

Setting credentials
code in "code --wait" is for VSCode, exchange it with your editor of choice

EDITOR="code --wait" rails credentials:edit
polygon:
  api_key: "YOUR_KEY"


Development
install dependencies bundle install
install node dependencies npm i
migrate/prepare the database rails db:migrate

   req_url = "https://api.polygon.io/v2/aggs/ticker/#{ticker_symbol}/prev?adjusted=true&apiKey=#{API_KEY}"
        headers = {
          'Content-Type': 'application/json'
        }
        response = HTTParty.get(req_url, headers: headers, format: :plain)
        json = JSON.parse response
        json['results'][0]['c'] # closing price
      end