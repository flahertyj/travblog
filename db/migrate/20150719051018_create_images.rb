class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.references :blog, index: true

      t.timestamps null: false
    end
  end
end
