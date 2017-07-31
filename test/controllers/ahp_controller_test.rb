require 'test_helper'

class AhpControllerTest < ActionDispatch::IntegrationTest
  test "should get base" do
    get ahp_base_url
    assert_response :success
  end

end
