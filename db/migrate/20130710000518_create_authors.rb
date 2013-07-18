class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name
      t.string :username
      t.string :aka
      t.string :job
      t.text :bio
      t.date :dob
      t.date :dod
      t.string :email
      t.string :social
      t.string :website
      t.string :type
      t.string :password_digest
      t.string :remember_token
      t.string :reset_token
      t.datetime :reset_token_sent_at
      t.integer :fans_count, default: 0
      t.integer :idols_count, default: 0

      t.timestamps
    end
  end
end
