# curl localhost:3000/api/v1/tags

class Api::V1::TagsController < ApplicationController
  def index
    render json: Tag.all
  end
end
