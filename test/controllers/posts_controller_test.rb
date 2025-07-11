require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @group = groups(:one)
    @post = posts(:one)
    @user = users(:one)
    sign_in @user
    GroupMembership.create!(user: @user, group: @group, role: 'admin')
  end

  test "should get index" do
    get group_posts_url(@group)
    assert_response :success
  end

  test "should get show" do
    get group_post_url(@group, @post)
    assert_response :success
  end

  test "should get new" do
    get new_group_post_url(@group)
    assert_response :success
  end

  test "should create post" do
    post group_posts_url(@group), params: { post: { title: 'Test Post', body: 'Body', min_age: 10, max_age: 20 } }
    assert_response :redirect
  end

  test "should get edit" do
    get edit_group_post_url(@group, @post)
    assert_response :success
  end

  test "should update post" do
    patch group_post_url(@group, @post), params: { post: { title: 'Updated Post' } }
    assert_response :redirect
  end

  test "should destroy post" do
    delete group_post_url(@group, @post)
    assert_response :redirect
  end
end
