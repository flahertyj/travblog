require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get forgot_password" do
    get :forgot_password
    assert_response :success
  end

end
