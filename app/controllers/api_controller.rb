class ApiController < ApplicationController
  respond_to :json
  load_and_authorize_resource except: [:create]
  skip_before_action :verify_authenticity_token if Rails.env == "development"
  include SerializeHelper

  def cur_user
    current_user || User.new
  end
end
