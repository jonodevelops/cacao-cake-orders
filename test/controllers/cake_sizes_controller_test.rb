require 'test_helper'

class CakeSizesControllerTest < ActionController::TestCase
  setup do
    @cake_size = cake_sizes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cake_sizes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cake_size" do
    assert_difference('CakeSize.count') do
      post :create, cake_size: {  }
    end

    assert_redirected_to cake_size_path(assigns(:cake_size))
  end

  test "should show cake_size" do
    get :show, id: @cake_size
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cake_size
    assert_response :success
  end

  test "should update cake_size" do
    patch :update, id: @cake_size, cake_size: {  }
    assert_redirected_to cake_size_path(assigns(:cake_size))
  end

  test "should destroy cake_size" do
    assert_difference('CakeSize.count', -1) do
      delete :destroy, id: @cake_size
    end

    assert_redirected_to cake_sizes_path
  end
end
