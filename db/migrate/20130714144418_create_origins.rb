class CreateOrigins < ActiveRecord::Migration
  def change
    create_table :origins do |t|
      t.string :title
      t.string :original_title
      t.date :publication
      t.text :content
      t.text :info
      t.string :video
      t.string :link
      t.integer :author_id
      t.string :type

      t.timestamps
    end
  end
end
