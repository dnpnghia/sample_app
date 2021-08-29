require "test_helper"

class MicropostControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get micropost_index_url
    assert_response :success
  end
end
