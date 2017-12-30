require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user.id)
    assert_template 'users/edit'
    patch user_path(@user), params: {user: {name: "",
                                            email: "foo@invalid",
                                            password: "foo",
                                            confirmation_password: "bar"}}
    assert_template 'users/edit'
  end

end
