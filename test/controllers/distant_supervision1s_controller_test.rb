require 'test_helper'

class DistantSupervision1sControllerTest < ActionController::TestCase
  setup do
    @distant_supervision1 = distant_supervision1s(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:distant_supervision1s)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create distant_supervision1" do
    assert_difference('DistantSupervision1.count') do
      post :create, distant_supervision1: {  }
    end

    assert_redirected_to distant_supervision1_path(assigns(:distant_supervision1))
  end

  test "should show distant_supervision1" do
    get :show, id: @distant_supervision1
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @distant_supervision1
    assert_response :success
  end

  test "should update distant_supervision1" do
    patch :update, id: @distant_supervision1, distant_supervision1: {  }
    assert_redirected_to distant_supervision1_path(assigns(:distant_supervision1))
  end

  test "should destroy distant_supervision1" do
    assert_difference('DistantSupervision1.count', -1) do
      delete :destroy, id: @distant_supervision1
    end

    assert_redirected_to distant_supervision1s_path
  end
end
