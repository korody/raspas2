class CreateReaspas < ActiveRecord::Migration
  def change
    create_table :reaspas do |t|
      t.belongs_to :raspa, index: true
      t.belongs_to :author, index: true

      t.timestamps
    end
  end
end
