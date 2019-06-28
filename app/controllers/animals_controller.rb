require 'rails_helper'

class AnimalsController < ApplicationController
  # Initialize the test data
  before_action :set_farm
  before_action :set_farm_animal, only: [:show, :update, :destroy]

  # GET /farms/:farm_id/animals
  def index
    json_response(@farm.animals)
  end

  # GET /farms/:farm_id/animals/:id
  def show
    json_response(@animal)
  end

  # POST /farms/:farm_id/animals
  def create
    @farm.animals.create!(animal_params)
    json_response(@farm, :created)
  end

  # PUT /farms/:farm_id/animals/:id
  def update
    @animal.update(animal_params)
    head :no_content
  end

  # DELETE /farms/:farm_id/animals/:id
  def destroy
    @animal.destroy
    head :no_content
  end

  private

  def animal_params
    params.permit(:name, :vegetarian)
  end

  def set_farm
    @farm = Farm.find(params[:farm_id])
  end

  def set_farm_animal
    @animal = @farm.animals.find_by!(id: params[:id]) if @farm
  end
end
