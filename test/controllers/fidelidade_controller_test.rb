require 'test_helper'

class FidelidadeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fidelidade_index_url
    assert_response :success
  end

end
