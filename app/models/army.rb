# = R-COM
# Web-based, multiplayer X-COM clone.
# Website:: http://r-com.rubyforge.org/
# Copyright:: WTFPL <http://sam.zoy.org/wtfpl/>

# A User's Army.
class Army < ActiveRecord::Base
  belongs_to :user
  has_many :squads

  validates_presence_of :user_id, :name
end
