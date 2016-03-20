class RegistrationsController < Devise::RegistrationsController


  def create
    build_resource(sign_up_params)

    if resource.save


      if resource.active_for_authentication?

        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)

        @current_user = current_user

        flash[:success] = "Successfully Signed In!"

        respond_to do |format|
          format.js { render template: '/users/registrations/create.js.erb'}
          format.html { redirect_to request.referer }
        end

        # return render :json => {:success => true}

      else

        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        return render :json => {:success => true}

      end
    else
      clean_up_passwords resource

      flash[:alert] = resource.errors.full_messages.to_sentence
      respond_to do |format|
        format.js { render template: '/users/registrations/signup_failed.js.erb'}
        format.html { redirect_to request.referer }
      end

      # return render :json => {:success => false}

    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :display_name)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :display_name, :current_password)
  end


end
