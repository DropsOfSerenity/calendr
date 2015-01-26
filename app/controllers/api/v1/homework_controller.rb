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
      trigger_user_pusher_action("create", @homework.id)
      respond_with :api, :v1, @homework
    else
      respond_with @homework
    end
  end

  def update
    @homework = Homework.find(params[:id])
    if @homework.update_attributes(homework_params)
      trigger_user_pusher_action("update", @homework.id)
    end
    respond_with @homework
  end

  private

  def trigger_user_pusher_action(action, id)
      Pusher.trigger("private-homework-#{current_user.id}", action, {id: id})
  end

  def homework_params
    params.require(:homework).permit(:title, :description, :subject, :due_date,
                                     :completed_at)
  end
end
