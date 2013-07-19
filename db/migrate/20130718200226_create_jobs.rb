class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name, index: true

      t.timestamps
    end
  end
end
