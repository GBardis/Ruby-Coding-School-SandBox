# Documentation # TODO: Documentation
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_locale
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, only: [:search_api, :destroy, :threat]

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  protected

  def authenticate_admin!
    if !user_signed_in?
      flash[:warning] = 'You need to login first'
      redirect_to login_path
    elsif current_user && !current_user.is_admin
      flash[:warning] = 'You do not have access to this resource'
      redirect_to root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname])
  end
  # def authenticate_user!
  #   if user_signed_in?
  #     super
  #   else
  #     redirect_to login_path, :notice => 'if you want to add a notice'
  #     ## if you want render 404 page
  #     ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
  #   end
  # end
end
