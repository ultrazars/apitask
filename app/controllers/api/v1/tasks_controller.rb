# curl localhost:3000/api/v1/tasks
# curl -X DELETE localhost:3000/api/v1/tasks/2

class Api::V1::TasksController < ApplicationController
  def index
    render json: Task.all
  end

  def create
    task = nil
    ActiveRecord::Base.transaction do
      task = Task.create!(task_params)
      task.set_tags(tags_params)
    end
    render json: task
  end

  def update
    task = Task.find(params[:id])
    task.assign_attributes(task_params)
    ActiveRecord::Base.transaction do
      task.save!
      task.set_tags(tags_params)
    end
    render json: task, include: "tags"
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy!
    render json: {success: true}
  end

  private

  def task_params
    params.require(:data).require(:attributes).permit(
      :title,
    )
  end

  def tags_params
    tags = params.require(:data).require(:attributes).permit(
      tags: [],
    )[:tags]
    Array.wrap(tags)
  end

end
