require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
  # follow_redirect!これで指定されたurlに移動する,この場合はusers/showに移動する
    assert_template 'users/show'
    assert is_logged_in?
    # assert_select 'div#<CSS id for error explanation>'これをコメントアウトから外すとエラーになる
    # assert_select 'div.<CSS class for field with error>'
  end
end
