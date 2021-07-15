class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == 'ユーザー'
      @search_users = User.looks(params[:word])
    elsif @range == 'ツイート'
      @search_tweets = Tweet.looks(params[:word])
    else
      @search_tags = Tag.looks(params[:word])
    end
  end
end
