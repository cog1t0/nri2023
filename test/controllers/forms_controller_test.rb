require "test_helper"

class FormsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get forms_show_url
    assert_response :success
  end

  test "should get create" do
    get forms_create_url
    assert_response :success
  end
end
