# = R-COM
# Web-based, multiplayer X-COM clone.
# Website:: http://r-com.rubyforge.org/
# Copyright:: WTFPL <http://sam.zoy.org/wtfpl/>

# This controller handles the login/logout function of the site.  
class AccountController < ApplicationController
  # render new.html.erb
  # Login form.
  def new
  end

  # Create the logged in session.
  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      if params[:remember_me] == "1"
        self.current_user.remember_me
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      redirect_back_or_default('/')
        flash[:notice] = 'Login successful.'
    else
      render :action => 'new'
    end
  end

  # Logout the User (destroy the session).
  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = 'You have been logged out.'
    redirect_back_or_default('/')
  end
end
