require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  test "user is valid" do
    assert @user.valid?
  end
end
