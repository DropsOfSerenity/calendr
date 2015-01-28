include ActionView::Helpers::DateHelper

class Api::V1::HomeworkController < ApplicationController
  before_filter :logged_in

  def index
    @homeworks = current_user.homeworks
    respond_with @homework
  end

  def show
    @homework = Homework.find(params[:id])
    respond_with @homework
  end

  def create
    homework = current_user.homeworks.new(homework_params)
    if homework.save
      trigger_user_pusher_action("create", homework.id)
      respond_with :api, :v1, homework
    else
      respond_with homework
    end
  end

  def update
    @homework = Homework.find(params[:id])
    if @homework.update_attributes(homework_params) and !homework_params.empty?
      trigger_user_pusher_action("update", @homework.id)
      respond_with @homework
    else
      render nothing: true, status: :bad_request
    end
  end

  private

  def logged_in
    render json: 'Bad credentials', status: 401 unless current_user
  end

  def trigger_user_pusher_action(action, id)
      Pusher.trigger("private-homework-#{current_user.id}", action, {id: id})
  end

  def homework_params
    params.require(:homework).permit(:title, :description, :subject, :due_date,
                                     :completed_at)
  end
end
