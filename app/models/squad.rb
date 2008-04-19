# = R-COM
# Web-based, multiplayer X-COM clone.
# Website:: http://r-com.rubyforge.org/
# Copyright:: WTFPL <http://sam.zoy.org/wtfpl/>

# A Squad of Soldiers.
class Squad < ActiveRecord::Base
  belongs_to :army
  has_many :soldiers

  validates_presence_of :army_id, :name
  validates_uniqueness_of :name, :message => 'is already taken.'
end
