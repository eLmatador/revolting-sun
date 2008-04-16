# = R-COM
# Web-based, multiplayer X-COM clone.
# Website:: http://r-com.rubyforge.org/

# Handles User creation/activation.
class UsersController < ApplicationController
  # Used to activate a newly created User.
  def activate
    self.current_user = params[:activation_code].blank? ? :false : User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.active?
      current_user.activate
      flash[:notice] = 'Your account has been created.  Please check your email.'
    end
    redirect_back_or_default('/')
  end

  # render new.html.erb
  # Signup form.
  def new
  end

  # Create the new User; gets input from 'new'.
  def create
    cookies.delete :auth_token
    @user = User.new(params[:user])
    @user.save!
    self.current_user = @user
    redirect_back_or_default('/')
    flash[:notice] = 'Thanks for signing up!'
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end
end
