module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def cp(path)
    "current-page" if current_page?(path)
  end

  def requires_login
    if !current_user
      'requires-login'
    end
  end
end
