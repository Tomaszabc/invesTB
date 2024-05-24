class ApplicationController < ActionController::Base
  helper_method :resource, :resource_name, :devise_mapping
  

  private

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  def can_delete_comment?(comment)
    return true if user_signed_in? && comment.user == current_user
    return true if session[:comment_ids]&.include?(comment.id)

    false
  end
end
