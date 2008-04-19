require File.dirname(__FILE__) + '/../test_helper'

class SquadTest < ActiveSupport::TestCase
  def test_create_squad
    assert_kind_of Squad, create_squad
  end

  def test_validate_belongs_to_army
    @squad = create_squad(:army_id => nil) # unset the Army
    assert_raise ActiveRecord::RecordInvalid do
      @squad.save!
    end
  end

  def test_validate_name
    @squad = create_squad(:name => nil) # unset the name
    assert_raise ActiveRecord::RecordInvalid do
      @squad.save!
    end
  end

  protected

  def create_squad(options = {})
    Squad.create( {
      :army_id => armies(:oshuma_army),
      :name => 'New Squad'
    }.merge(options) )
  end
end
