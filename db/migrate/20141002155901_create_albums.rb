class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name, null: false
      t.integer :band_id, index: true, null: false
      t.string :album_type, null: true

      t.timestamps
    end
  end
end
