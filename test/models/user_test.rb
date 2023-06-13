require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = active_user
  end

    test "name_validation" do
    # 入力必須
    user = User.new(email: "test@example.com", password: "password")
    user.save
    required_msg = ["Name can't be blank"]
    assert_equal(required_msg, user.errors.full_messages)

    # 文字数制限
    max = 30
    name = "a" * (max + 1)
    user.name = name
    user.save
    maxlength_msg = ["Name is too long (maximum is 30 characters)"]
    assert_equal(maxlength_msg, user.errors.full_messages)

    # 30文字以内は正しく保存されているか
    name = "あ" * max
    user.name = name
    assert_difference("User.count", 1) do
      user.save
    end
  end
end