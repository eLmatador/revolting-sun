# = R-COM
# Web-based, multiplayer X-COM clone.
# Website:: http://r-com.rubyforge.org/
# Copyright:: WTFPL <http://sam.zoy.org/wtfpl/>

# Handles the front page of the site (as well as misc other things).
class HomeController < ApplicationController
  # Front page.
  def index
    @page_title = 'Home'
  end
end

