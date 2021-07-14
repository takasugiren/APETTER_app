class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]

    if @range == 'ユーザー'
      @users = User.looks(params[:word])
    elsif @range == 'ツイート'
      @tweets = Tweet.looks(params[:word])
    else 
      @tags = Tag.looks(params[:word])
    end
  end
end
