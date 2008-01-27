require File.dirname(__FILE__) + '/../test_helper'

class HomeControllerTest < ActionController::TestCase
  def test_front_page
    get :index
    assert assigns(@page_title)
    assert_response :success
  end
end
