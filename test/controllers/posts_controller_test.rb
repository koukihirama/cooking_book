require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:taro) # ここを 'taro' に修正します
    sign_in @user       # Devise のログインヘルパー
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end
end