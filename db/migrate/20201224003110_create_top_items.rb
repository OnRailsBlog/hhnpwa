class CreateTopItems < ActiveRecord::Migration[6.1]
  def change
    create_table :top_items do |t|
      t.references :item, null: false, foreign_key: true
      t.integer :location

      t.timestamps
    end
    add_index :top_items, :location
  end
end
