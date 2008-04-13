# = R-COM
# Web-based, multiplayer X-COM clone.
# Author:: Dale Campbell <oshuma@gmail.com>

# Handles the front page of the site (as well as misc other things).
class HomeController < ApplicationController
  # Front page.
  def index
    @page_title = 'Home'
  end
end
