require "test_helper"

class Admin::VendorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @vendor = vendors(:one)
    # Login as admin
    post admin_login_url, params: { email: @admin.email, password: "password" }
  end

  test "should get index" do
    get admin_vendors_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_vendor_url
    assert_response :success
  end

  test "should create vendor" do
    assert_difference("Vendor.count") do
      post admin_vendors_url, params: { vendor: { address: @vendor.address, bank_reference: @vendor.bank_reference, email: "new_vendor@example.com", name: @vendor.name, phone: @vendor.phone, status: @vendor.status } }
    end

    assert_redirected_to admin_vendors_path
  end

  test "should show vendor" do
    get admin_vendor_url(@vendor)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_vendor_url(@vendor)
    assert_response :success
  end

  test "should update vendor" do
    patch admin_vendor_url(@vendor), params: { vendor: { address: @vendor.address, bank_reference: @vendor.bank_reference, email: @vendor.email, name: @vendor.name, phone: @vendor.phone, status: @vendor.status } }
    assert_redirected_to admin_vendors_path
  end

  test "should destroy vendor" do
    assert_difference("Vendor.count", -1) do
      delete admin_vendor_url(@vendor)
    end

    assert_redirected_to admin_vendors_path
  end
end
