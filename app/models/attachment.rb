class Attachment < ActiveRecord::Base

  belongs_to :attachable, polymorphic: true

  mount_uploader :image, ImageUploader

  before_create do
    self.note ||= File.basename(image.filename, '.*').titleize if image
  end

end
