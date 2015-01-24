class Api::V1::HomeworkController < ApplicationController
  def index
    @homeworks = Homework.where(user_id: current_user.id)
    respond_with @homework
  end

  def show
    @homework = Homework.find(params[:id])
    respond_with @homework
  end
end
