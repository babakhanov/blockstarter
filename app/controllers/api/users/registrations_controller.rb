class Api::Users::RegistrationsController < Devise::RegistrationsController
  after_filter :set_csrf_headers

  protected

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :company_name, :address)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def set_csrf_headers
    cookies['XSRF-TOKEN'] = form_authenticity_token
  end
end
