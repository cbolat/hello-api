class EmployeesController < ApplicationController
  before_action :set_project
  before_action :set_project_employee, only: [:show, :update, :destroy]

  def index
    json_response(@project.employees)
  end

  def show
    json_response(@employee)
  end

  def create
    @project.employees.create!(employee_params)
    json_response(@project, :created)
  end

  def update
    @employee.update(employee_params)
    head :no_content
  end

  def destroy
    @employee.destroy
    head :no_content
  end

  private

  def employee_params
    params.permit(:name, :paid)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_project_employee
    @employee = @project.employees.find_by!(id: params[:id]) if @project
  end
end
