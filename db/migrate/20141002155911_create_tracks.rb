class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name, null: false
      t.text :lyrics, null: false
      t.integer :album_id, index: true, null: false
      t.string :track_type, null: false

      t.timestamps
    end
  end
end
