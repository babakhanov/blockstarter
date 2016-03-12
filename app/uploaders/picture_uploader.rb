class PictureUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  def filename
    "#{secure_token(10)}.#{file.extension}" if original_filename.present?
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :large do
    resize_to_limit(200, 200)
  end

  version :normal do
    resize_to_limit(80, 80)
  end

  def extension_white_list
    %w(jpg jpeg png)
  end

  protected

  def secure_token(length=16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
  end
end
