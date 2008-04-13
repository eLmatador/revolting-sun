# = R-COM
# Web-based, multiplayer X-COM clone.
# Author:: Dale Campbell <oshuma@gmail.com>
# Website:: http://r-com.rubyforge.org/

# Holds application-wide methods and filters.
class ApplicationController < ActionController::Base
  # restful_authentication plugin.
  include AuthenticatedSystem

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'c72943fa6ea2087d34e06503d3d299ee'
end
