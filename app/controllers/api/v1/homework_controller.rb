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
      homework_json = Rabl::Renderer.json(@homework, 'homework/show',
                                        :view_path => 'app/views/api/v1')
      Pusher.trigger("private-homework-#{current_user.id}", "create", homework_json)
      respond_with :api, :v1, @homework
    else
      respond_with @homework
    end
  end

  private

  def homework_params
    puts params
    params.require(:homework).permit(:title, :description, :subject, :due_date)
  end
end
