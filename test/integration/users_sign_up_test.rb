require "test_helper"

class UsersSignUpTest < ActionDispatch::IntegrationTest
  test "get signup form and create user" do
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { firstname: "John", lastname: "Doe", email: "johndoe@example.com", password: "password" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Welcome John, thanks for signing up!", response.body
  end
end
