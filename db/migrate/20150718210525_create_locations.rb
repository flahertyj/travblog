class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.decimal :lat, :precision => 15, :scale => 10
      t.decimal :lng, :precision => 15, :scale => 10

      t.timestamps null: false
    end
  end
end
