require 'test_helper'

class CakeStylesControllerTest < ActionController::TestCase
  setup do
    @cake_style = cake_styles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cake_styles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cake_style" do
    assert_difference('CakeStyle.count') do
      post :create, cake_style: { current: @cake_style.current, name: @cake_style.name }
    end

    assert_redirected_to cake_style_path(assigns(:cake_style))
  end

  test "should show cake_style" do
    get :show, id: @cake_style
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cake_style
    assert_response :success
  end

  test "should update cake_style" do
    patch :update, id: @cake_style, cake_style: { current: @cake_style.current, name: @cake_style.name }
    assert_redirected_to cake_style_path(assigns(:cake_style))
  end

  test "should destroy cake_style" do
    assert_difference('CakeStyle.count', -1) do
      delete :destroy, id: @cake_style
    end

    assert_redirected_to cake_styles_path
  end
end
