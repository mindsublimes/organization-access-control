require "test_helper"

class GroupMembershipsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @group = groups(:one)
    @group_membership = group_memberships(:one)
    @user = users(:one)
    sign_in @user
    GroupMembership.create!(user: @user, group: @group, role: 'admin')
  end

  test "should get index" do
    get group_group_memberships_url(@group)
    assert_response :success
  end

  test "should create group_membership" do
    post group_group_memberships_url(@group), params: { email: 'newuser@example.com' }
    assert_response :redirect
  end

  test "should update group_membership" do
    patch group_group_membership_url(@group, @group_membership), params: { role: 'admin' }
    assert_response :redirect
  end

  test "should destroy group_membership" do
    delete group_group_membership_url(@group, @group_membership)
    assert_response :redirect
  end
end
