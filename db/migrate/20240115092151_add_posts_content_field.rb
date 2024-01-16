class AddPostsContentField < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :content, :text
  end
end
