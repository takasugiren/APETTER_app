class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.text :body
      t.string :image_id
      t.integer :user_id

      t.timestamps
    end
  end
end
