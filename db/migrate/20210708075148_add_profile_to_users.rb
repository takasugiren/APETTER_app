class AddProfileToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :profile, :text
    add_column :users, :profile_image_id, :string
    add_column :users, :rank, :integer, default: 0, null: false
    add_column :users, :ratio, :float
  end
end
