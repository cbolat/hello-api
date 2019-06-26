  class SingersController < ApplicationController
    before_action :set_singer, only: [:show, :update, :destroy]

    # GET /singers
    def index
      # get current user singers
      @singers = current_user.singers.paginate(page: params[:page], per_page: 20)
      json_response(@singers)
    end

    # GET /singers/:id
    def show
      json_response(@singer)
    end

    # POST /singers
    def create
      # create singers belonging to current user
      @singer = current_user.singers.create!(singer_params)
      json_response(@singer, :created)
    end

    # PUT /singers/:id
    def update
      @singer.update(singer_params)
      head :no_content
    end

    # DELETE /singers/:id
    def destroy
      @singer.destroy
      head :no_content
    end

    private

    # remove `created_by` from list of permitted parameters
    def singer_params
      params.permit(:name)
    end

    def set_singer
      @singer = Singer.find(params[:id])
    end
  end


