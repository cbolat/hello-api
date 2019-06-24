class V2::TodosController < ApplicationController
  def index
    binding.pry
    json_response({message: 'Hello there'})
  end
end
