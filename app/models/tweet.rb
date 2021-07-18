class Tweet < ApplicationRecord
  belongs_to :user
  # tweetが削除されるとその投稿に関連してるtagが削除される
  has_many :tag_maps, dependent: :destroy
  # throughオプションを使う場合、先にその中間テーブルとの関連付けを行う必要がある
  has_many :tags, through: :tag_maps

  has_many :tweet_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  attachment :image

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.looks(word)
    @search_tweets = Tweet.where("body LIKE?", "%#{word}%")
  end

  def save_tag(sent_tags)
    # ツイートのcreateアクションにて保存した＠tweetに紐付いているタグが存在する場合、タグの名前を配列として全て取得する
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    # 取得した@tweetの存在するタグから、送信されてきたタグを除いたタグをold_tagsとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから、現在存在するタグを除いたタグをnew_tagsとする
    new_tags = sent_tags - current_tags

    # 古いタグの削除
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_tag
    end
  end

  def create_notification_like!(current_user)
    # すでにいいねされているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and tweet_id = ? and action = ?", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        tweet_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, tweet_comment_id)
    # 自分以外にコメントしている人全て取得し、全員に通知を送る
    temp_ids = TweetComment.select(:user_id).where(tweet_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, tweet_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, tweet_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, tweet_comment_id, visited_id)
    # コメントは複数回することが考えられるため、1つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      tweet_id: id,
      tweet_comment_id: tweet_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
