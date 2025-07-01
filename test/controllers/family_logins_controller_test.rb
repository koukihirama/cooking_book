require "test_helper"

class FamilyLoginsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get family_logins_new_url
    assert_response :success
  end

  test "should get create" do
    get family_logins_create_url
    assert_response :success
  end
end
