require File.dirname(__FILE__) + '/../test_helper'

class UserTest < Test::Unit::TestCase
  def test_should_create_user
    assert_difference 'User.count' do
      user = create_user
      assert !user.new_record?, "#{user.errors.full_messages.to_sentence}"
    end
  end

  def test_should_initialize_activation_code_upon_creation
    user = create_user
    assert_not_nil user.activation_code
  end

  def test_should_require_login
    assert_no_difference 'User.count' do
      u = create_user(:login => nil)
      assert u.errors.on(:login)
    end
  end

  def test_should_require_password
    assert_no_difference 'User.count' do
      u = create_user(:password => nil)
      assert u.errors.on(:password)
    end
  end

  def test_should_require_password_confirmation
    assert_no_difference 'User.count' do
      u = create_user(:password_confirmation => nil)
      assert u.errors.on(:password_confirmation)
    end
  end

  def test_should_require_email
    assert_no_difference 'User.count' do
      u = create_user(:email => nil)
      assert u.errors.on(:email)
    end
  end

  def test_should_reset_password
    users(:admin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal users(:admin), User.authenticate('admin', 'new password')
  end

  def test_should_not_rehash_password
    users(:admin).update_attributes(:login => 'admin2')
    assert_equal users(:admin), User.authenticate('admin2', 'test')
  end

  def test_should_authenticate_user
    assert_equal users(:admin), User.authenticate('admin', 'test')
  end

  def test_already_activated_flag
    assert_equal users(:testguy), User.authenticate('testguy', 'test', :already_activated => true)
  end

  def test_should_set_remember_token
    users(:admin).remember_me
    assert_not_nil users(:admin).remember_token
    assert_not_nil users(:admin).remember_token_expires_at
  end

  def test_should_unset_remember_token
    users(:admin).remember_me
    assert_not_nil users(:admin).remember_token
    users(:admin).forget_me
    assert_nil users(:admin).remember_token
  end

  def test_should_remember_me_for_one_week
    before = 1.week.from_now.utc
    users(:admin).remember_me_for 1.week
    after = 1.week.from_now.utc
    assert_not_nil users(:admin).remember_token
    assert_not_nil users(:admin).remember_token_expires_at
    assert users(:admin).remember_token_expires_at.between?(before, after)
  end

  def test_should_remember_me_until_one_week
    time = 1.week.from_now.utc
    users(:admin).remember_me_until time
    assert_not_nil users(:admin).remember_token
    assert_not_nil users(:admin).remember_token_expires_at
    assert_equal users(:admin).remember_token_expires_at, time
  end

  def test_should_remember_me_default_two_weeks
    before = 2.weeks.from_now.utc
    users(:admin).remember_me
    after = 2.weeks.from_now.utc
    assert_not_nil users(:admin).remember_token
    assert_not_nil users(:admin).remember_token_expires_at
    assert users(:admin).remember_token_expires_at.between?(before, after)
  end

  def test_for_admin_rights
    assert_equal true, users(:admin).admin
  end

  def test_for_no_admin_rights
    assert_equal false, users(:oshuma).admin
  end

  protected

  def create_user(options = {})
    User.create( {
      :login => 'newguy',
      :email => 'newguy@localhost',
      :password => 'NEW PASS',
      :password_confirmation => 'NEW PASS',
      :admin => false
    }.merge(options) )
  end
end
