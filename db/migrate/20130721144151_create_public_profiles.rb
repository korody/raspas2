class CreatePublicProfiles < ActiveRecord::Migration
  def change
    create_table :public_profiles do |t|
      t.string :aka
      t.date :dod

      t.timestamps
    end
  end
end
