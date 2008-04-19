# = R-COM
# Web-based, multiplayer X-COM clone.
# Website:: http://r-com.rubyforge.org/
# Copyright:: WTFPL <http://sam.zoy.org/wtfpl/>

# Holds application-wide methods and filters.
class ApplicationController < ActionController::Base
  # restful_authentication plugin.
  include AuthenticatedSystem

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details.
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'c72943fa6ea2087d34e06503d3d299ee'

  # Redirects out of the controller/action if there is a User logged in.
  def redirect_if_logged_in
    redirect_to root_path if logged_in?
  end
end
