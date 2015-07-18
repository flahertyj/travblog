class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.float :latitude, :precision => 15, :scale => 10
      t.float :longitude, :precision => 15, :scale => 10

      t.timestamps null: false
    end
  end
end
