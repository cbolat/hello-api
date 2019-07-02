class PostsController < ApplicationController
  before_action :set_note
  before_action :set_note_post, only: [:show, :update, :destroy]

  def index
    json_response(@note.posts)
  end

  def show
    json_response(@post)
  end

  def create
    @note.posts.create!(post_params)
    json_response(@note, :created)
  end

  def update
    @post.update(post_params)
    head :no_content
  end

  def destroy
    @post.destroy
    head :no_content
  end

  private

  def post_params
    params.permit(:name, :done)
  end

  def set_note
    @note = Note.find(params[:note_id])
  end

  def set_note_post
    @post = @note.posts.find_by!(id: params[:id]) if @note
  end
end
