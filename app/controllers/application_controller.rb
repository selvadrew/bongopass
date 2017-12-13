class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_cache_headers
  
  private

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end


  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end



  protected
  	def configure_permitted_parameters 
  		devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname])
  		devise_parameter_sanitizer.permit(:account_update, keys: [:fullname, :email, :password])
  	end


    def after_sign_in_path_for(resource)
      request.env['omniauth.origin'] || stored_location_for(resource) || purchases_path
    end

 

end
