class RemoveTitleFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :title, :string
  end
end
