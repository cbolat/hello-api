class CustomersController < ApplicationController
  before_action :set_todo
  before_action :set_todo_customer, only: [:show, :update, :destroy]

  def index
    json_response(@todo.customers)
  end

  def show
    json_response(@customer)
  end

  def create
    @todo.customers.create!(customer_params)
    json_response(@todo, :created)
  end

  def update
    @customer.update(customer_params)
    head :no_content
  end

  def destroy
    @customer.destroy
    head :no_content
  end

  private

  def customer_params
    params.permit(:name, :done)
  end

  def set_todo
    @todo = Todo.find(params[:todo_id])
  end

  def set_todo_customer
    @customer = @todo.customers.find_by!(id: params[:id]) if @todo
  end
end
