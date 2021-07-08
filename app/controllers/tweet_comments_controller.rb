class TweetCommentsController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @tweet_comment = current_user.tweet_comments.new(tweet_comment_params)
    @tweet_comment.tweet_id = @tweet.id
    @tweet_comment.save
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @tweet_comment_id = params[:id]
    TweetComment.find_by(id: params[:id], tweet_id: params[:tweet_id]).destroy
  end

  private

  def tweet_comment_params
    params.require(:tweet_comment).permit(:comment)
  end
end
