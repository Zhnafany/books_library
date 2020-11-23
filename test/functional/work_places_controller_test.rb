require 'test_helper'

class WorkPlacesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:work_places)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create work_place" do
    assert_difference('WorkPlace.count') do
      post :create, :work_place => { }
    end

    assert_redirected_to work_place_path(assigns(:work_place))
  end

  test "should show work_place" do
    get :show, :id => work_places(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => work_places(:one).to_param
    assert_response :success
  end

  test "should update work_place" do
    put :update, :id => work_places(:one).to_param, :work_place => { }
    assert_redirected_to work_place_path(assigns(:work_place))
  end

  test "should destroy work_place" do
    assert_difference('WorkPlace.count', -1) do
      delete :destroy, :id => work_places(:one).to_param
    end

    assert_redirected_to work_places_path
  end
end
