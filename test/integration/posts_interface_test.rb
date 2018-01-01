require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "Post interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
      # Case 1: Empty description and title
      assert_no_difference 'Post.count' do
        post posts_path, params: { post: { title: "", description: "" } }
      end
      assert_select 'div#error_explanation'
      # Case 2: Empty description
      assert_no_difference 'Post.count' do
        post posts_path, params: { post: {title: "title is present", description: ""}}
      end
      # Case 3: Empty title
      assert_no_difference 'Post.count' do
        post posts_path, params: { post: {title: "", description: "description is present but the title is not present"}}
      end
    # Valid submission
    title = "This post really ties the room together"
    description = "This is the description of the post. Hope you will like it"
    assert_difference 'Post.count', 1 do
      post posts_path, params: { post: { title: title ,description: description} }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match title, response.body
    assert_match description, response.body
    # Delete post
    assert_select 'a', text: 'delete'
    first_post = @user.posts.paginate(page: 1).first
    assert_difference 'Post.count', -1 do
      delete post_path(first_post)
    end
    # Visit different user (no delete links)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
