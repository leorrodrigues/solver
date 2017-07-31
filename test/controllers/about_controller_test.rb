require 'test_helper'

class AboutControllerTest < ActionDispatch::IntegrationTest
  test "should get info" do
    get about_info_url
    assert_response :success
  end

end
