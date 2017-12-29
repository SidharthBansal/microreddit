require 'test_helper'

class UsersSignUpTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: {name: "",
                                        email: "user@invallid",
                                        password: "foo",
                                        password_confirmation: "foo"}}
    end
    assert_template 'users/new'
  end



end
