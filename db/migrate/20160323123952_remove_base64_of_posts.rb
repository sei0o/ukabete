class RemoveBase64OfPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :base64
  end
end
