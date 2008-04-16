# = R-COM
# Web-based, multiplayer X-COM clone.
# Website:: http://r-com.rubyforge.org/

require 'digest/sha1'

# Stores User data.
class User < ActiveRecord::Base
  # Field validations.
  validates_presence_of     :login, :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :login, :email, :case_sensitive => false

  before_save :encrypt_password
  before_create :make_activation_code

  # Prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation

  # Virtual attribute for the unencrypted password.
  attr_accessor :password

  # Activates the user in the database.
  def activate
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  # The existence of an activation code means they have not activated yet.
  def active?
    activation_code.nil?
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password, options = {})
    options[:already_activated] ||= false
    if options[:already_activated]
      user = find :first, :conditions => { :login => login }
    else
      user = find :first, :conditions => ['login = ? AND activated_at IS NOT NULL', login]
    end
    user && user.authenticated?(password) ? user : nil
  end

  # Return true if the given password hash matches the stored one.
  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Instance method which is a class wrapper to User.encrypt.
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  # Removes the remember_token.
  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def pending?
    @activated
  end

  # Returns true if the remember token hasn't expired.
  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at
  end

  # Wrapper to remember_me_for.
  def remember_me
    remember_me_for 2.weeks
  end

  # Wrapper to remember_me_until.
  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  # Sets the remember_token.
  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  protected
    # before_filter to encrypt a plaintext password and generate a salt if it's a new User.
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
      self.crypted_password = encrypt(password)
    end

    # Returns true if the password is required for validation.
    def password_required?
      crypted_password.blank? || !password.blank?
    end

    # Generates an activation_code upon User creation.
    def make_activation_code
      self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    end
end
