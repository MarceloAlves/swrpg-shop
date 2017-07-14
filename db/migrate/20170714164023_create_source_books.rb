class CreateSourceBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :source_books do |t|
      t.string :key, null: false
      t.string :title, null: false
      t.string :collection

      t.timestamps
    end
  end
end
