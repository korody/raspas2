class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.text :note
      t.string :image
      t.belongs_to :attachable, polymorphic: true

      t.timestamps
    end
    add_index :attachments, :attachable_id
  end
end
