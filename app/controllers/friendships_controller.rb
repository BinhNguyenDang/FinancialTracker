class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save 
      flash[:notice] = "Following successfully!"
    else
      flash[:alert] = "Error"
    end
      redirect_to following_path
  end

  def destroy
    friendship = current_user.friendships.where(params[:id]).first
    friendship.destroy
    flash[:notice] = "Succesfully unfollowed!"
    redirect_to following_path
  end
end
