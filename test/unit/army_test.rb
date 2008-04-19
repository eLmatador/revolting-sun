require File.dirname(__FILE__) + '/../test_helper'

class ArmyTest < ActiveSupport::TestCase
  def test_create_army
    assert_kind_of Army, create_army
  end

  def test_validate_belongs_to_user
    @army = create_army(:user_id => nil) # unset the User
    assert_raise ActiveRecord::RecordInvalid do
      @army.save!
    end
  end

  def test_validate_name
    @army = create_army(:name => nil) # unset the name
    assert_raise ActiveRecord::RecordInvalid do
      @army.save!
    end
  end

  def test_name_uniqueness
    @army = create_army(:name => 'New Army')
    assert @army.save
    @evil_army = create_army(:name => 'New Army') # same as above
    assert_raise ActiveRecord::RecordInvalid do
      @evil_army.save!
    end
  end

  protected

  def create_army(options = {})
    Army.create( {
      :user_id => users(:oshuma),
      :name => 'New Army'
    }.merge(options) )
  end
end
