class WelcomeController < ApplicationController
  # before_action :configure_permitted_parameters
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  # protected
  #
  # def configure_permitted_parameters
  # devise_parameter_sanitizer.permit(:sign_in) do |user_params|
  #   user_params.permit(:name, :email)
  #   end
  # end

  def show
  end

  def index
  end

  def about
  end
end
