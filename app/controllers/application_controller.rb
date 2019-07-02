class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :authorize_request
  attr_reader :current_userb

  private

  def authorize_request
    @current_userb = (AuthorizeApiRequest.new(request.headers).call)[:userb]
  end
end
