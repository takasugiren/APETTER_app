class FavoritesController < ApplicationController
  # いいね作成アクション
  def create
    @tweet = Tweet.find(params[:tweet_id])
    favorite = current_user.favorites.new(tweet_id: @tweet.id)
    favorite.save
    @tweet.create_notification_like!(current_user)
  end
  # いいね削除アクション
  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    favorite = current_user.favorites.find_by(tweet_id: @tweet.id)
    favorite.destroy
  end
end
