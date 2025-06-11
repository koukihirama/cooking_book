require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) # users.yml で定義されたユーザー
    sign_in @user       # Devise のログインヘルパー
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end
end