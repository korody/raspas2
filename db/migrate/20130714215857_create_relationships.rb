class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.belongs_to :author
      t.belongs_to :idol

      t.timestamps
    end
    add_index :relationships, :author
    add_index :relationships, :idol
  end
end