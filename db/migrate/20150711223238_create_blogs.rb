class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.datetime :posted_time
      t.string :image
      t.string :body

      t.timestamps null: false
    end
  end
end
