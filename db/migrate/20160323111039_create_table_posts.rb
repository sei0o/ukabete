class CreateTablePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :message
      t.string :url
      t.text :base64

      t.timestamps
    end
  end
end
