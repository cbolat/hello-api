class OrdersController < ApplicationController
  before_action :set_todo
  before_action :set_todo_order, only: [:show, :update, :destroy]

  def index
    json_response(@todo.orders)
  end

  def show
    json_response(@order)
  end

  def create
    @todo.orders.create!(order_params)
    json_response(@todo, :created)
  end

  def update
    @order.update(order_params)
    head :no_content
  end

  def destroy
    @order.destroy
    head :no_content
  end

  private

  def order_params
    params.permit(:name, :done)
  end

  def set_todo
    @todo = Todo.find(params[:todo_id])
  end

  def set_todo_order
    @order = @todo.orders.find_by!(id: params[:id]) if @todo
  end
end
