class Asset < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  belongs_to :user
  belongs_to :wif

  def issue
    debugger
  end
end
