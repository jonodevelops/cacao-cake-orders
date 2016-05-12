class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :confirm_logged_in, except: [:login, :attempt_login]

	private
  	def params_date(prefix)
		Date.civil(params[prefix][:year].to_i, params[prefix][:month].to_i, params[prefix][:day].to_i)
	end

  def redirect_back_or_default(default = :orders, options = {})
  redirect_to (request.referer.present? ? :back : default), options
end

	def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = "Please log in."
      redirect_to(:controller => 'access', :action => 'login')
      return false
    else
      return true
    end
  end

  def allow_admin
    unless User.find(session[:user_id]).admin
      flash[:notice] = "Please log in as an Admin."
      redirect_back_or_default
    end
  end

end
