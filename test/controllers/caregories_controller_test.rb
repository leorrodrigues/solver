require 'test_helper'

class CaregoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @caregory = caregories(:one)
  end

  test "should get index" do
    get caregories_url
    assert_response :success
  end

  test "should get new" do
    get new_caregory_url
    assert_response :success
  end

  test "should create caregory" do
    assert_difference('Caregory.count') do
      post caregories_url, params: { caregory: { name: @caregory.name, node: @caregory.node, tree: @caregory.tree } }
    end

    assert_redirected_to caregory_url(Caregory.last)
  end

  test "should show caregory" do
    get caregory_url(@caregory)
    assert_response :success
  end

  test "should get edit" do
    get edit_caregory_url(@caregory)
    assert_response :success
  end

  test "should update caregory" do
    patch caregory_url(@caregory), params: { caregory: { name: @caregory.name, node: @caregory.node, tree: @caregory.tree } }
    assert_redirected_to caregory_url(@caregory)
  end

  test "should destroy caregory" do
    assert_difference('Caregory.count', -1) do
      delete caregory_url(@caregory)
    end

    assert_redirected_to caregories_url
  end
end
