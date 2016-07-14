require 'test_helper'

class RankingsControllerTest < ActionController::TestCase
  test "should get national" do
    get :national
    assert_response :success
  end

  test "should get state" do
    get :state
    assert_response :success
  end

  test "should get league" do
    get :league
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
