require File.dirname(__FILE__) + '/../test_helper'

class ArmyControllerTest < ActionController::TestCase
  def test_show_army
    login_as(:oshuma)
    get :show
    assert_response :success
  end

  def test_create_army
    users(:testguy).activate # activate them so we can create an Army
    login_as(:testguy)
    post :create, :army => { :name => 'Testguy Army', :user_id => users(:testguy).id }
    assert_response :redirect
  end
end
