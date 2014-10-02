class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :band_id, index: true, null: false
      t.integer :track_id, index: true, null: false

      t.timestamps
    end
  end
end
