require "test_helper"

class Admin::EmployeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @employee = employees(:one)
    # Login as admin
    post admin_login_url, params: { email: @admin.email, password: "password" }
  end

  test "should get index" do
    get admin_employees_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_employee_url
    assert_response :success
  end

  test "should create employee" do
    assert_difference("Employee.count") do
      post admin_employees_url, params: { employee: { department: @employee.department, email: "new_employee@example.com", first_name: @employee.first_name, hire_date: @employee.hire_date, last_name: @employee.last_name, phone: @employee.phone, position: @employee.position, salary: @employee.salary } }
    end

    assert_redirected_to admin_employees_url
  end

  test "should show employee" do
    get admin_employee_url(@employee)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_employee_url(@employee)
    assert_response :success
  end

  test "should update employee" do
    patch admin_employee_url(@employee), params: { employee: { department: @employee.department, email: @employee.email, first_name: @employee.first_name, hire_date: @employee.hire_date, last_name: @employee.last_name, phone: @employee.phone, position: @employee.position, salary: @employee.salary } }
    assert_redirected_to admin_employees_url
  end

  test "should destroy employee" do
    assert_difference("Employee.count", -1) do
      delete admin_employee_url(@employee)
    end

    assert_redirected_to admin_employees_url
  end
end
