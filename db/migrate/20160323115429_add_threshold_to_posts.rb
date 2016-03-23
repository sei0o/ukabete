class AddThresholdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :threshold, :integer
  end
end
