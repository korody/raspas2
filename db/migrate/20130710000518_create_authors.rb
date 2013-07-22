class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.string :username
      t.text :bio
      t.date :dob
      t.string :social
      t.string :website
      t.integer :fans_count, default: 0
      t.integer :idols_count, default: 0
      t.integer :profile_id, index: true
      t.string :profile_type, index: true
      t.string :remember_token

      t.timestamps
    end
  end
end