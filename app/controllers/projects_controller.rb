class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  def index
    @projects = Project.filter(params.slice(:starts_with))
    json_response(@projects)
  end

  def create
    @project = current_userb.projects.create!(project_params)
    json_response(@project, :created)
  end

  def show
    json_response(@project)
  end

  def update
    @project.update(project_params)
    head :no_content
  end

  def destroy
    @project.destroy
    head :no_content
  end

  def showall
    @project = current_userb.projects
    render json: @project, include: 'employees'
  end

  private

  def project_params
    params.permit(:title)
  end

  def set_project
    @project = Project.find(params[:id])
  end


end
