class Api::Users::SessionsController < Devise::SessionsController
  after_filter :set_csrf_headers

  protected

  def set_csrf_headers
    cookies['XSRF-TOKEN'] = form_authenticity_token
  end
end
