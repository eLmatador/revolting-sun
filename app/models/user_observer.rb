# = R-COM
# Web-based, multiplayer X-COM clone.
# Website:: http://r-com.rubyforge.org/
# Copyright:: WTFPL <http://sam.zoy.org/wtfpl/>

# Watches for changes in a User model.
class UserObserver < ActiveRecord::Observer
  # Sends a message after a User activates their account.
  def after_create(user)
    UserMailer.deliver_signup_notification(user)
  end

  # Sends an activation email to a new User.
  def after_save(user)
    UserMailer.deliver_activation(user) if user.pending?
  end
end
