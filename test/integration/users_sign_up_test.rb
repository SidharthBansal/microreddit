require 'test_helper'

class UsersSignUpTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid signup information" do
    get signup_path

    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do
      post users_path, params: { user: {name: "",
                                        email: "user@invallid",
                                        password: "foo",
                                        password_confirmation: "foo"}}
    end

    assert_select 'form[action="/signup"]'
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'
    assert_select 'div.alert'
  end

  test "valid sign_up with account activation" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {name: "Example User",
                                        email: "user@example.com",
                                        password: "password",
                                        password_confirmation: "password"}}
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activation?
    # Try to login before activation
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid account activation token
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path("invalid token", email: 'wrong')
    assert_not is_logged_in?
    # Valid account activation token and email
    get edit_account_activation_path(user.activation_token, email: user.email
    )
    assert user.reload.activation?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end


end
