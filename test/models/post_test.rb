require 'test_helper'

class PostTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    # This code is not idiomatically correct.
    @post = @user.posts.build(title: "Lorem ipsum",
                      description: "This is my first post")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "description should be present" do
    @post.description = ""
    assert_not @post.valid?
  end

  test "description should be atmost 500 chars" do
    @post.description = "a"*501
    assert_not @post.valid?
  end

  test "description must be greater than 19 chars" do
    @post.description = "p"*19
    assert_not @post.valid?
  end


    test "title should be present" do
      @post.title = ""
      assert_not @post.valid?
    end

    test "title should be atmost 50 chars" do
      @post.title = "a"*51
      assert_not @post.valid?
    end

    test "title must be greater than 2 chars" do
      @post.title = "p"*2
      assert_not @post.valid?
    end
end
