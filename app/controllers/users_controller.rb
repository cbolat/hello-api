class UsersController < ApplicationController
  before_action :set_job
  before_action :set_job_user, only: [:show, :update, :destroy]

  def index
    json_response(@job.users)
  end

  def show
    json_response(@user)
  end

  def create
    @job.users.create!(user_params)
    json_response(@job, :created)
  end

  def update
    @user.update(user_params)
    head :no_content
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private
  def user_params
    params.permit(:name)
  end

  def set_job
    @job= Job.find(params[:job_id])
  end

  def set_job_user
    @user=@job.users.find_by!(id: params[:id]) if @job
  end

end
