require 'test_helper'

class EducationalInstitutionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:educational_institutions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create educational_institution" do
    assert_difference('EducationalInstitution.count') do
      post :create, :educational_institution => { }
    end

    assert_redirected_to educational_institution_path(assigns(:educational_institution))
  end

  test "should show educational_institution" do
    get :show, :id => educational_institutions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => educational_institutions(:one).to_param
    assert_response :success
  end

  test "should update educational_institution" do
    put :update, :id => educational_institutions(:one).to_param, :educational_institution => { }
    assert_redirected_to educational_institution_path(assigns(:educational_institution))
  end

  test "should destroy educational_institution" do
    assert_difference('EducationalInstitution.count', -1) do
      delete :destroy, :id => educational_institutions(:one).to_param
    end

    assert_redirected_to educational_institutions_path
  end
end
