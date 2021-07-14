class Tweet < ApplicationRecord
  belongs_to :user
  # tweetが削除されるとその投稿に関連してるtagが削除される
  has_many :tag_maps, dependent: :destroy
  # throughオプションを使う場合、先にその中間テーブルとの関連付けを行う必要がある
  has_many :tags, through: :tag_maps

  has_many :tweet_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
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
end
