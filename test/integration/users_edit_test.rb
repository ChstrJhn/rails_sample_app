require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  setup do
  	@user = users(:one)
  end

  test "unsuccessful edit" do
  	log_in_as(@user)
  	get edit_user_path(@user)
  	assert_template 'users/edit'
  	patch user_path(@user), user: {name: "",email:"fuck", password:"",password_confirmation:"fuck"}
  	assert_template 'users/edit'
  end

  test "successful_edit" do
  	log_in_as(@user)
  	get edit_user_path(@user)
  	assert_template 'users/edit'
  	name = "John Fuckin Cena"
  	email = "johnfuckincena@gmail.com"
  	patch user_path(@user), user:{name: name, email: email, password:"", password_confirmation:""}
  	assert_not flash.empty?
  	assert_redirected_to @user
  	@user.reload
  	assert_equal @user.name, name
  	assert_equal @user.email, email
  end

  test "successful edit with friendly forwarding" do
  	get edit_user_path(@user)
  	log_in_as(@user)
  	assert_redirected_to edit_user_path(@user)
  	name = "Kiko"
  	email = "kiko@gmail.com"
  	patch user_path(@user), user: {name: name, email: email, password:"foobar",password_confirmation:"foobar"}
  	assert_not flash.empty?
  	assert_redirected_to @user
  	@user.reload
  	assert_equal @user.name, name
  	assert_equal @user.email, email
  end

end
