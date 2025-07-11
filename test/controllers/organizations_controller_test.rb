require "test_helper"

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @organization = organizations(:one)
  end

  test "should get index" do
    get organizations_url
    assert_response :success
  end

  test "should get show" do
    get organization_url(@organization)
    assert_response :success
  end

  test "should get new" do
    get new_organization_url
    assert_response :success
  end

  test "should create organization" do
    post organizations_url, params: { organization: { name: 'Test Org', min_age: 10, max_age: 20 } }
    assert_response :redirect
  end

  test "should get edit" do
    get edit_organization_url(@organization)
    assert_response :success
  end

  test "should update organization" do
    patch organization_url(@organization), params: { organization: { name: 'Updated Org' } }
    assert_response :redirect
  end

  test "should destroy organization" do
    delete organization_url(@organization)
    assert_response :redirect
  end
end
