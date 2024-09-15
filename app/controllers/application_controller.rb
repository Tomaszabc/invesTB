class ApplicationController < ActionController::Base
  include CommentPermissions
  helper_method :resource, :resource_name, :devise_mapping, :can_delete_comment?

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
end
