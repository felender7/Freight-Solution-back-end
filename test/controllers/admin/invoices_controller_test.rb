require "test_helper"

class Admin::InvoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @invoice = invoices(:one)
    # Login as admin
    post admin_login_url, params: { email: @admin.email, password: "password" }
  end

  test "should get index" do
    get admin_invoices_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_invoice_url
    assert_response :success
  end

  test "should create invoice" do
    assert_difference("Invoice.count") do
      post admin_invoices_url, params: { invoice: { amount: @invoice.amount, due_date: @invoice.due_date, invoice_number: "INV-9999", paid_date: @invoice.paid_date, status: @invoice.status, vendor_id: @invoice.vendor_id } }
    end

    assert_redirected_to admin_invoices_path
  end

  test "should show invoice" do
    get admin_invoice_url(@invoice)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_invoice_url(@invoice)
    assert_response :success
  end

  test "should update invoice" do
    patch admin_invoice_url(@invoice), params: { invoice: { amount: @invoice.amount, due_date: @invoice.due_date, invoice_number: @invoice.invoice_number, paid_date: @invoice.paid_date, status: @invoice.status, vendor_id: @invoice.vendor_id } }
    assert_redirected_to admin_invoices_path
  end

  test "should destroy invoice" do
    assert_difference("Invoice.count", -1) do
      delete admin_invoice_url(@invoice)
    end

    assert_redirected_to admin_invoices_path
  end
end
