class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.belongs_to :author, index: true
      t.belongs_to :idol, index: true

      t.timestamps
    end
  end
end