class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.integer :author_id
      t.integer :job_id

      t.timestamps
    end
  end
end
