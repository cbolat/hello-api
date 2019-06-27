class MissionsController < ApplicationController
  before_action :set_todo
  before_action :set_todo_mission, only: [:show, :update, :destroy]

  def index
    json_response(@todo.missions)
  end

  def show
    json_response(@mission)
  end

  def create
    @todo.missions.create!(mission_params)
    json_response(@todo, :created)
  end

  def update
    @mission.update(mission_params)
    head :no_content
  end

  def destroy
    @mission.destroy
    head :no_content
  end

  private

  def mission_params
    params.permit(:code)
  end

  def set_todo
    @todo = Todo.find(params[:todo_id])
  end

  def set_todo_mission
    @mission = @todo.missions.find_by!(id: params[:id]) if @todo
  end
end
