require 'test_helper'

class GaleriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get galeries_index_url
    assert_response :success
  end

end
