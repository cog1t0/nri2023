require "test_helper"

class FormsControllerTest < ActionDispatch::IntegrationTest
  test "should get profile_get" do
    get forms_profile_get_url
    assert_response :success
  end
end
