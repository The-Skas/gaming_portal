require 'test_helper'

class TictactoesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
