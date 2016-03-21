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

  def photo_path
    (Rails.env.production? ? "public/imagemagick/fact_photos/" : "public/fact_photos/")
  end

  def controller_action
    "#{params[:controller]}\##{params[:action]}"
  end

  def meta_tags
    tags = {}
    tags[:description] = "Truthometer enables truth to unfold via a collaborative process of evidence collection and verification."

    case controller_action
    when "facts#show"
      tags[:title] = "#{@fact.body} | Truthometer"
    when "facts#index"
      tags[:title] = "Browse Facts | Truthometer"
    when "facts#new"
      tags[:title] = "New Facts | Truthometer"
    when "static_pages#home"
      tags[:title] = "Truthometer"
    when "static_pages#about"
      tags[:title] = "About | Truthometer"
    when "static_pages#forum"
      tags[:title] = "Forum | Truthometer"
    when "users#show"
      tags[:title] = "#{@user.display_name} | Truthometer"
    end

    tags

  end
end
