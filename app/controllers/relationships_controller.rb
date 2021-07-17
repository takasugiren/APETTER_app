class RelationshipsController < ApplicationController
  # フォロー作成アクション
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  # フォロー削除アクション
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  # フォロー・フォロワー一覧画面で使うメソッド
  def followings
    @user = User.find(params[:user_id])
    # userモデルで定義したfollowingsを使用
    @users = @user.followings
  end
  def followers
    @user = User.find(params[:user_id])
    # userモデルで定義したfollowersを使用
    @users = @user.followers
  end
end
