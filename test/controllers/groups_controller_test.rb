require "test_helper"

class GroupsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @group = groups(:one)
    @user = users(:one)
    sign_in @user
    GroupMembership.create!(user: @user, group: @group, role: 'admin')
  end

  test "should get index" do
    get groups_url
    assert_response :success
  end

  test "should get show" do
    get group_url(@group)
    assert_response :success
  end

  test "should get new" do
    get new_group_url
    assert_response :success
  end

  test "should create group" do
    post groups_url, params: { group: { name: 'Test Group', min_age: 10, max_age: 20 } }
    assert_response :redirect
  end

  test "should get edit" do
    get edit_group_url(@group)
    assert_response :success
  end

  test "should update group" do
    patch group_url(@group), params: { group: { name: 'Updated Group' } }
    assert_response :redirect
  end

  test "should destroy group" do
    delete group_url(@group)
    assert_response :redirect
  end
end
