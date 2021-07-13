class Tag < ApplicationRecord
  # tag_mapsテーブルとの関連付けを行なってから、tag_mapsを通してtweetsテーブルと関連付けている
  has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :tweets, through: :tag_maps
end
