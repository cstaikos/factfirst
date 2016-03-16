class CustomFailure < Devise::FailureApp

  def redirect_url
    respond_to do |format|
      format.js { render template: '/users/sessions/create.js.erb'}
      format.html {}
    end
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end
