class StocksController < ApplicationController

    def search
        if params[:stock].present?
            @stock = Stock.new_lookup(params[:stock])
            if @stock
                respond_to do |f|
                    f.turbo_stream { render turbo_stream: turbo_stream.replace('results', partial: 'users/result', locals: {stock: @stock})}
                end
              else
                flash.now[:alert] = 'Please enter a valid symbol to search'
                render 'users/my_portfolio', status: :bad_request
              end
        else
            flash[:alert] = "Please enter a symbol to search"
            redirect_to my_portfolio_path
        end
    end

end
