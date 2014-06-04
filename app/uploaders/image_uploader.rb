# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  if Rails.env.production?
      storage :fog
    else
     storage :file
    end

  def store_dir
    "#{model.class.to_s.underscore}/#{model.id}"
  end

  def default_url
    "logo.png"
  end

# Process files as they are uploaded:
  process   :resize_to_fill => [1920, 1080]
  

  version :tiny do
    process :resize_to_fill => [32, 32]
  end

  version :small do
    process :resize_to_fill => [65, 65]
  end

  version :medium do
    process :resize_to_fill => [130, 130]
  end

  version :regular do
    process :resize_to_fill => [600, 600]
  end

  version :profile do
    process :resize_to_fill => [200, 200]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
