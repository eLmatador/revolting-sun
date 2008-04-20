# = R-COM
# Web-based, multiplayer X-COM clone.
# Website:: http://r-com.rubyforge.org/
# Copyright:: WTFPL <http://sam.zoy.org/wtfpl/>

# Handles User creation/activation.
class UsersController < ApplicationController
  before_filter :redirect_if_logged_in

  # Used to activate a newly created User.
  def activate
    self.current_user = params[:activation_code].blank? ? :false : User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.active?
      current_user.activate
      # flash[:notice] = 'Your account has been activated.'
    end
    redirect_to embassy_path
  end

  # render new.html.erb
  # Sign up form.
  def new
  end

  # Create the new User; gets input from 'new'.
  def create
    cookies.delete :auth_token
    @user = User.new(params[:user])
    @user.save!
    self.current_user = @user
    redirect_back_or_default('/')
    flash[:notice] = 'Your account has been created.  Please check your email.'
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end
end
