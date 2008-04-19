# = R-COM
# Web-based, multiplayer X-COM clone.
# Website:: http://r-com.rubyforge.org/
# Copyright:: WTFPL <http://sam.zoy.org/wtfpl/>

# An individual Soldier.
class Soldier < ActiveRecord::Base
  belongs_to :army
  belongs_to :squad

  validates_presence_of :army_id, :squad_id
  validates_presence_of :name, :message => 'must not be empty.'
  validates_presence_of :health, :armor, :actions, :accuracy, :strength
end
