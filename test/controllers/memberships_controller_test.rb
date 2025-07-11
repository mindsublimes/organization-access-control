require "test_helper"

class MembershipsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @organization = organizations(:one)
    @membership = memberships(:one)
    @user = users(:one)
    sign_in @user
    Membership.create!(user: @user, organization: @organization, role: 'admin')
  end

  test "should get index" do
    get organization_memberships_url(@organization)
    assert_response :success
  end

  test "should create membership" do
    post organization_memberships_url(@organization), params: { email: 'newuser@example.com' }
    assert_response :redirect
  end

  test "should update membership" do
    patch organization_membership_url(@organization, @membership), params: { role: 'admin' }
    assert_response :redirect
  end

  test "should destroy membership" do
    delete organization_membership_url(@organization, @membership)
    assert_response :redirect
  end
end
