# = Revolting Sun
# Web-based, multiplayer X-COM clone.
# Website:: http://revolting-sun.rubyforge.org/
# Copyright:: WTFPL <http://sam.zoy.org/wtfpl/>

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Loops through the flash messages and returns them.
  def display_flash
    flash_names = [ :notice, :warning ]
    flash_list = String.new

    flash_names.each do |name|
      if flash[name]
        flash_list << "<p id='flash_#{name.to_s}'>"
        flash_list << "<a href='#' onclick=\"$('flash_#{name.to_s}').hide(); return false;\">[X]</a>"
        flash_list << "#{flash[name]}"
        flash_list << "</p>\n"
      end
      flash[name] = nil  # Clear it.
    end

    # Return them to the view.
    unless flash_list.empty?
      return flash_list
    end
  end

  # Include a per-controller sidebox, defaulting to 'home' if none is found.
  def include_page_box(controller)
    if controller =~ /^admin/ # nested admin controller?
      nested_controller = controller.split('/').last
      admin_partial = RAILS_ROOT + "/app/views/shared/dark-mint/page_boxes/admin/_#{nested_controller}.html.erb"
      if File.exists?(admin_partial)
        render :partial => "shared/dark-mint/page_boxes/admin/#{nested_controller}"
      else
        # Default to admin page box, if no nested one is found.
        render :partial => 'shared/dark-mint/page_boxes/admin'
      end
    else
      # Non-nested controller.
      partial = RAILS_ROOT + "/app/views/shared/dark-mint/page_boxes/_#{controller}.html.erb"
      if File.exists?(partial)
        render :partial => "shared/dark-mint/page_boxes/#{controller}"
      else
        render :partial => 'shared/dark-mint/page_boxes/home'
      end
    end
  end

  # Returns true if the currently logged in User is an administrator.
  def is_admin?
    logged_in? && current_user.admin
  end

  # Outputs a link tag with conditional 'current' CSS class.
  # This method needs a Hash as the +url+ option.
  def link_to_with_current(link_name, url = {})
    match = /^#{controller.controller_path.split('/').first}\w*/
    if url[:controller] =~ match
      '<li id="current">' + link_to(link_name, url) + '</li>'
    else
      '<li>' + link_to(link_name, url) + '</li>'
    end
  end
end