class CreateGenrings < ActiveRecord::Migration
  def change
    create_table :genrings do |t|
      t.integer :origin_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
