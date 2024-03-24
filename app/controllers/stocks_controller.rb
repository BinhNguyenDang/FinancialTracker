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

end
