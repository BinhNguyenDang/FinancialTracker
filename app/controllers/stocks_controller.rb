class StocksController < ApplicationController

    def search
        if params[:stock].present?
            @stock = Stock.new_lookup(params[:stock].upcase)
            if @stock
                respond_to do |f|
                    f.turbo_stream { render turbo_stream: turbo_stream.replace('results', partial: 'users/result', locals: {stock: @stock})}
                end
              else
                flash[:alert] = 'Please enter a valid symbol to search'
                redirect_to my_portfolio_path
              end
        else
            flash[:alert] = "Please enter a symbol to search"
            redirect_to my_portfolio_path
        end
    end

    def update
        @stock = Stock.find(params[:id])
        updated_info = Stock.new_lookup(@stock.ticker) # Make sure this method exists and fetches the latest data
        
        if updated_info.present?
          @stock.update(
            last_price: updated_info.last_price,
            high_price: updated_info.high_price,
            low_price: updated_info.low_price,
            opening_price: updated_info.opening_price,
            volume: updated_info.volume,
            vwap: updated_info.vwap
          )
          flash[:notice] = "#{@stock.name} updated successfully."
          turbo_stream { render turbo_stream: turbo_stream.replace('list', partial: 'stocks/list', locals: {stock: @stock})}
        else
          flash[:alert] = "Failed to update #{@stock.name}."
          
        end
    
        redirect_to my_portfolio_path
    end

end
