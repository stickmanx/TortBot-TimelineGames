require 'test_helper'

class GameSearchControllerTest < ActionController::TestCase
  test "should get games" do
    get :games
    assert_response :success
  end

end
