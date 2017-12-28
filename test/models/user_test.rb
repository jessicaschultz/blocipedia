require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "test username", email: "test@email.com", password: "testing123")
  end

  # test "should be valid" do
  #   assert @user.present?
  # end

  # test "name should be present" do
  #   @user.name = ""
  #   assert_not @user.valid?
  # end

  # test "email should be present" do
  #   @user.email = " "
  #   assert_not @user.valid?
  # end
end
