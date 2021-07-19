class TweetsController < ApplicationController
  def index
    @tag_list = Tag.all
     @tweets = Tweet.all
     # where(user_id: [current_user.id, *current_user.following_ids])
  end

  def new
    @tweet = Tweet.new
  end

  def show
    @tweet = Tweet.find(params[:id])
    @tweet_comment = TweetComment.new
    @tweet_tags = @tweet.tags
  end

  def search
    @tag = Tag.find(params[:tag_id])  #参照したタグを取得
    @tweets = @tag.tweets.all         #参照したタグに紐付けられた投稿を全て表示
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    # params[:tweet][:tag_name]　formから@tweetオブジェクトを参照してタグの名前も一緒に送信するのでこの形で取得する
    # .split(nil)　送られてきた値を、スペースで区切って配列化する 配列化する理由は後でこの値をデータベースに保存する際に1つずつ繰り返し処理で取り出す必要があるため
    tag_list = params[:tweet][:tag_name].split(nil)
    if @tweet.save
      # タグの配列をデータベースに保存する処理
      @tweet.save_tag(tag_list)
      redirect_to tweets_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    @tweet.update(tweet_params)
    redirect_to tweet_path(@tweet)
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to tweets_path
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body, :image)
  end
end
