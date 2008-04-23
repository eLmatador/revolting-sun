# = Revolting Sun
# Web-based, multiplayer X-COM clone.
# Website:: http://revolting-sun.rubyforge.org/
# Copyright:: WTFPL <http://sam.zoy.org/wtfpl/>

# An individual Soldier.
class Soldier < ActiveRecord::Base
  belongs_to :army
  belongs_to :squad

  validates_presence_of :army_id, :squad_id
  validates_presence_of :name, :message => 'must not be empty.'
  validates_uniqueness_of :name, :message => 'is already taken.'
  validates_presence_of :health, :armor, :actions, :accuracy, :strength
end
