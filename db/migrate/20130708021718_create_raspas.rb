class CreateRaspas < ActiveRecord::Migration
  def change
    create_table :raspas do |t|
      t.text :quote
      t.integer :user_id
      t.integer :author_id
      t.integer :origin_id
      t.text :note
      t.boolean :published, default: true
      t.integer :citations_count, default: 0

      t.timestamps
    end
  end
end
