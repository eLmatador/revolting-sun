# = R-COM
# Web-based, multiplayer X-COM clone.
# Website:: http://r-com.rubyforge.org/
# Copyright:: WTFPL <http://sam.zoy.org/wtfpl/>

# Stores informatino about a User's Embassy.
class Embassy < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, :name
  validates_uniqueness_of :name, :message => 'is already taken.'
end
