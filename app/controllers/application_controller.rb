# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  # skip_before_action :authorize_request, only: :create
  # skip_before_action :authorize_request, only: :authenticate

  # called before every action on controllers
  before_action :authorize_request
  attr_reader :current_user

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end


  skip_before_action :authorize_request, only: :authenticate
end

# class ApplicationController < ActionController::API
#   include ActionController::MimeResponds
# end
#
# class PostsController < ApplicationController
#   def index
#     posts = Post.all
#
#     respond_to do |format|
#       format.json { render json: posts }
#       format.xml  { render xml: posts }
#     end
#   end
# end