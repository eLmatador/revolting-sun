require File.dirname(__FILE__) + '/../test_helper'

class SoldierTest < ActiveSupport::TestCase
  def test_create_soldier
    assert_kind_of Soldier, create_soldier
  end

  def test_validate_belongs_to_squad
    @soldier = create_soldier(:squad_id => nil) # unset the Squad
    assert_raise ActiveRecord::RecordInvalid do
      @soldier.save!
    end
  end

  def test_validate_belongs_to_army
    @soldier = create_soldier(:army_id => nil) # unset the Army
    assert_raise ActiveRecord::RecordInvalid do
      @soldier.save!
    end
  end

  protected

  def create_soldier(options = {})
    Soldier.create( {
      :army_id => armies(:oshuma_army),
      :squad_id => squads(:ninja_robots),
      :name => 'New Soldier',
      :health => rand_stat(30, 50),
      :actions => rand_stat(10, 20),
      :strength => rand_stat(10, 50),
      :armor => 0,
      :accuracy => 0
    }.merge(options) )
  end
end
