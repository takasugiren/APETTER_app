class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) } #常に新しい通知データを取得する事ができる
  belongs_to :tweet, optional: true             # optional: trueはnilを許可するもの
  belongs_to :tweet_comment, optional: true     # optional: trueはnilを許可するもの

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true 
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
