class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :by
      t.bigint :hn_id
      t.bigint :parent_id
      t.text :text
      t.boolean :dead
      t.datetime :time
      t.integer :location

      t.timestamps
    end
    add_index :comments, :hn_id
    add_index :comments, :parent_id
  end
end
