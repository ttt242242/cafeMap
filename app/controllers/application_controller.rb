class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    map_index_path
  end

  private
  def sign_in_required
    redirect_to new_user_session_url unless user_signed_in?
  end
end
