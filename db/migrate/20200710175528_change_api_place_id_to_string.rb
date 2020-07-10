class ChangeApiPlaceIdToString < ActiveRecord::Migration[6.0]
  def change
    change_column :places, :api_place_id, :string
  end
end
