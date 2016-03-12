class Asset < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
end
