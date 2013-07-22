class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :email
      t.string :password_digest
      t.string :reset_token
      t.datetime :reset_token_sent_at

      t.timestamps
    end
  end
end
