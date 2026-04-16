require "test_helper"

class Admin::ShipmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @shipment = shipments(:one)
    # Login as admin
    post admin_login_url, params: { email: @admin.email, password: "password" }
  end

  test "should get index" do
    get admin_shipments_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_shipment_url
    assert_response :success
  end

  test "should create shipment" do
    assert_difference("Shipment.count") do
      post admin_shipments_url, params: { shipment: { booking_reference: "NEW-REF-123", container_number: @shipment.container_number, destination: @shipment.destination, estimated_arrival: @shipment.estimated_arrival, origin: @shipment.origin, ship_date: @shipment.ship_date, status: @shipment.status } }
    end

    assert_redirected_to admin_shipments_path
  end

  test "should show shipment" do
    get admin_shipment_url(@shipment)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_shipment_url(@shipment)
    assert_response :success
  end

  test "should update shipment" do
    patch admin_shipment_url(@shipment), params: { shipment: { booking_reference: @shipment.booking_reference, container_number: @shipment.container_number, destination: @shipment.destination, estimated_arrival: @shipment.estimated_arrival, origin: @shipment.origin, ship_date: @shipment.ship_date, status: @shipment.status } }
    assert_redirected_to admin_shipments_path
  end

  test "should destroy shipment" do
    assert_difference("Shipment.count", -1) do
      delete admin_shipment_url(@shipment)
    end

    assert_redirected_to admin_shipments_path
  end
end
