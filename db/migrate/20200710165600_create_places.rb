class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :name
      t.integer :api_place_id
      t.boolean :bar
      t.string :image_url
      t.float :lat
      t.float :lon
      t.integer :category_id

      t.timestamps
    end
  end
end
