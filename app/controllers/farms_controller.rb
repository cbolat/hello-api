class FarmsController < ApplicationController
  before_action :set_farm, only: [:show, :update, :destroy]

  # GET /farms
  def index
    #@farms = Farm.all
    @farms = current_user.farms
    json_response(@farms)
  end

  # POST /farms
  def create
    #@farm = Farm.create!(farm_params)
    @farm = current_user.farms.create!(farm_params)
    json_response(@farm, :created)
  end

  # GET /farms/:id
  def show
    json_response(@farm)
  end

  # PUT /farms/:id
  def update
    @farm.update(farm_params)
    head :no_content
  end

  # DELETE /farms/:id
  def destroy
    @farm.destroy
    head :no_content
  end

  private

  def farm_params
    # whitelist params
    params.permit(:name)
  end

  def set_farm
    @farm = Farm.find(params[:id])
  end

end
