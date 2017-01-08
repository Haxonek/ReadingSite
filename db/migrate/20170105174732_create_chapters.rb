class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :title
      t.string :description
      t.string :tags, default: ""
      # t.integer :volume, default: 0
      t.text :content
      t.decimal :rating, precision: 3, scale: 2
      t.references :book, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
