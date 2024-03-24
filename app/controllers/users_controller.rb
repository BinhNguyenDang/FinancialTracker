class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def index
    @friends = current_user.friends
  end

  def search
    term = params[:users]
    if term.present?
      @friend = User.search(term)
      if @friend
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.update('user', partial: 'users/user_result', locals: { friend: @friend }) }
        end
      else
        flash[:alert] = 'No users found for the given term'
        redirect_to following_path
      end
    else
      flash[:alert] = 'Please enter a firstname or email'
      redirect_to following_path
    end
  end


end
  

