# = Revolting Sun
# Web-based, multiplayer X-COM clone.
# Website:: http://revolting-sun.rubyforge.org/
# Copyright:: WTFPL <http://sam.zoy.org/wtfpl/>

# A User's Army.
class Army < ActiveRecord::Base
  belongs_to :user
  has_many :squads
  has_many :soldiers

  validates_presence_of :user_id
  validates_presence_of :name, :message => 'must not be empty.'
  validates_uniqueness_of :name, :message => 'is already taken.'
end
