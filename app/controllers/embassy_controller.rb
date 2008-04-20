# = R-COM
# Web-based, multiplayer X-COM clone.
# Website:: http://r-com.rubyforge.org/
# Copyright:: WTFPL <http://sam.zoy.org/wtfpl/>

# Embassy management.
class EmbassyController < ApplicationController
  before_filter :login_required
  before_filter :load_embassy, :except => [ :new, :create ]

  # Save the new Embassy; gets input from 'new'.
  def create
    @embassy = Embassy.new(params[:embassy])
    @embassy.user_id = current_user.id
    @embassy.save!
    flash[:notice] = "Your embassy named '#{@embassy.name}' was created."
    redirect_to new_army_path
  rescue ActiveRecord::RecordInvalid
    render :action => 'new'
  end

  # Display the Embassy creation form.
  # Called upon User activation (from UsersController#activate).
  def new
    @page_title = 'Create Embassy'
    respond_to do |format|
      format.html # render new.html.erb
    end
  end

  # Embassy management front-end.
  def show
    @page_title = 'Embassy Management'
    respond_to do |format|
      format.html # render show.html.erb
      format.xml { render :xml => @embassy.to_xml }
    end
  end

  protected

  # Loads the currently logged in User's Embassy.
  def load_embassy
    return unless logged_in?
    @embassy = current_user.embassy
    if @embassy.nil? # User has no Embassy.
      redirect_to new_embassy_path
    end
  end
end
