require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(firstname: "John", lastname: "Doe", email: "johndoe@example.com", password: "password")
    sign_in_as(@user)
    @category = Category.create(name: "Sports")
  end

  test "get new article form and create article" do
    get "/articles/new"
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: "My Test Article", description: "This is a test article", category_ids: [1] } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Article was created successfully.", response.body
  end
end
