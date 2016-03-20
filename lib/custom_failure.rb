class CustomFailure < Devise::FailureApp

  def redirect_url
    flash[:alert] = "Invalid login or password"
    request.referer
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end
