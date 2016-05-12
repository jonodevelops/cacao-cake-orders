class AccessController < ApplicationController
before_action :allow_admin, except: [:login, :attempt_login, :logout]

def login
	
end

def attempt_login
	if params[:username].present? && params[:password].present?
      found_user = User.where(:username => params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end
    if authorized_user
      # mark user as logged in
      session[:user_id] = authorized_user.id
      session[:username] = authorized_user.username
      flash[:notice] = "You are now logged in."
      if authorized_user.admin
       redirect_to :admin_panel
      else
        redirect_to :orders
      end
    else
      flash[:notice] = "Invalid username/password combination."
      redirect_to :login
    end
	
end

def admin_panel
  
end

def logout
  session[:user_id] = nil
  session[:username] = nil
  flash[:notice] = "Logged out"
  redirect_to :login
end

end
