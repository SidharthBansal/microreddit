require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @comment = comments(:one)
    @user1 = users(:michael)
    @user2 = users(:lana)
    @post1 = posts(:orange)
    @post2 = posts(:cat_video)
  end

  test "valid comment" do
    assert @comment.valid?
  end

  test "comment should have user" do
    @comment.user = nil
    assert_not @comment.valid?
  end

  test "comment should have post" do
    @comment.post = nil
    assert_not @comment.valid?
  end
end
