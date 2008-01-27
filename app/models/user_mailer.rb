# = R-COM
# Web-based, multiplayer X-COM clone.
# Author:: Dale Campbell <oshuma@gmail.com>

# Sends notifications to Users.
class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://#{AppConfig.app_url}/activate/#{user.activation_code}"
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://#{AppConfig.app_url}/"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = AppConfig.app_email
      @subject     = "[#{AppConfig.app_name}] "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
