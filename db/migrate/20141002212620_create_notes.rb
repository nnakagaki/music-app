class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :user_id, index: true, null: false
      t.integer :track_id, index: true, null: false
      t.text :body, null: false

      t.timestamps
    end
  end
end
