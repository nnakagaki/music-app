class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name, null: false
      t.integer :user_id, index: true, null: false

      t.timestamps
    end
  end
end
