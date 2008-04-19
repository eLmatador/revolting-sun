# = R-COM
# Web-based, multiplayer X-COM clone.
# Website:: http://r-com.rubyforge.org/
# Copyright:: WTFPL <http://sam.zoy.org/wtfpl/>

# Army management.
class ArmyController < ApplicationController
  before_filter :login_required
  before_filter :load_army, :except => [ :new, :create ]

  # Create the new User; gets input from 'new'.
  def create
    @army = Army.new(params[:army])
    @army.user_id = current_user.id
    @army.save!
    flash[:notice] = "Your army named '#{@army.name}' was created."
    redirect_to army_path
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

  # Create a new Army.  Called upon User activation (from UsersController#activate).
  def new
    @page_title = "Create Army"
    respond_to do |format|
      format.html # render new.html.erb
    end
  end

  # Army management front-end.
  def show
    @page_title = "Army Management"
    respond_to do |format|
      format.html # render index.html.erb
      format.xml { render :xml => @army.to_xml }
    end
  end

  protected

  # Loads the currently logged in User's Army.
  def load_army
    return unless logged_in?
    @army = current_user.army
    if @army.nil?
      redirect_to new_army_path
    end
  end
end
