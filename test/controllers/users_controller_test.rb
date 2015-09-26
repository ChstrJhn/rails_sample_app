require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  setup do
    @user = users(:one)
    @other_user = users(:two)
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should get index" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count', 1) do
      post :create, user: { email: 'notthesame@email.com', name: @user.name, password: 'password', password_confirmation: 'password'}
    end
    
    assert_redirected_to root_url
    # assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    log_in_as(@user)
    patch :update, id: @user, user: { email: @user.email, name: @user.name,password:"",password_confirmation:"" }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id:@user, user: {name: @user.name, email: @user.email}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as other user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id:@user, user: {name: @user.name, email: @user.email}
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      log_in_as(@user)
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch :update, id: @other_user, user: {password:"111222333", password_confirmation:"111222333", admin: true}
    assert_not @other_user.admin?
  end

end
