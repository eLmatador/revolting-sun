# = R-COM
# Web-based, multiplayer X-COM clone.
# Website:: http://r-com.rubyforge.org/

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Loops through the flash messages and returns them.
  def display_flash
    flash_names = [ :notice, :warning ]
    flash_list = String.new

    flash_names.each do |name|
      if flash[name]
        # If a message is there, add it to the list.
        flash_list << "<p id='flash_#{name.to_s}' class='app_message'>"
        flash_list << "<a href='#' onclick=\"$('flash_#{name.to_s}').hide(); return false;\">[X]</a>"
        flash_list << "#{flash[name]}</p>"
      end
      flash[name] = nil # clear it
    end

    unless flash_list.empty?
      return flash_list
    end
  end

  # Outputs a link tag with conditional 'active' CSS class.
  def link_to_with_active(link_name, url = {})
    match = /^#{controller.controller_path.split('/').first}\w*/
    if url[:controller] =~ match
      html_options = { :class => 'active' }
    end
    return link_to(link_name, url, html_options)
  end
end
