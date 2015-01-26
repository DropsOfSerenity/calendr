include ActionView::Helpers::DateHelper

class Api::V1::HomeworkController < ApplicationController
  def index
    @homeworks = Homework.where(user_id: current_user.id)
    respond_with @homework
  end

  def show
    @homework = Homework.find(params[:id])
    respond_with @homework
  end

  def create
    @homework = Homework.create(homework_params.merge(:user_id => current_user.id))
    if @homework.save
      Pusher.trigger("private-homework-#{current_user.id}",
                     "create", render_homework_json(@homework))
      respond_with :api, :v1, @homework
    else
      respond_with @homework
    end
  end

  def update
    @homework = Homework.find(params[:id])
    @homework.update(homework_params)
    respond_with @homework
  end

  private

  def homework_params
    params.require(:homework).permit(:title, :description, :subject, :due_date,
                                     :completed)
  end

  def render_homework_json(homework)
      Rabl::Renderer.json(homework, 'homework/show',
                          :view_path => 'app/views/api/v1')
  end
end
