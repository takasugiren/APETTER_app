class CreateTweetComments < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_comments do |t|
      t.integer :user_id
      t.integer :tweet_id
      t.text :comment

      t.timestamps
    end
  end
end
