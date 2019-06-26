
  class SongsController < ApplicationController
    before_action :set_singer
    before_action :set_singer_song, only: [:show, :update, :destroy]

    # GET /singers/:singer_id/songs
    def index
      json_response(@singer.songs)
    end

    # GET /singers/:singer_id/songs/:id
    def show
      json_response(@song)
    end

    # POST /singers/:singer_id/songs
    def create
      @singer.songs.create!(song_params)
      json_response(@singer, :created)
    end

    # PUT /singers/:singer_id/songs/:id
    def update
      @song.update(song_params)
      head :no_content
    end

    # DELETE /singers/:singer_id/songs/:id
    def destroy
      @song.destroy
      head :no_content
    end

    private

    def song_params
      params.permit(:name, :done)
    end

    def set_singer
      @singer = Singer.find(params[:singer_id])
    end

    def set_singer_song
      @song = @singer.songs.find_by!(id: params[:id]) if @singer
    end
  end

