class TagMap < ApplicationRecord
  belongs_to :tweet
  belongs_to :tag
  # この2つの外部キーは絶対必要なので、バリデーションをかける
  validates :tweet_id, presence: true
  validates :tag_id, presence: true
end
