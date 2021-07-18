class TweetComment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  has_many :notifications, dependent: :destroy

  validates :comment, presence: true
end
