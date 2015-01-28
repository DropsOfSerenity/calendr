class Api::V1::SubjectController < ApplicationController
  before_filter :logged_in

  def index
    @subjects = current_user.subjects
    respond_with @subjects
  end

  def show
    @subject = Subject.find(params[:id])
    respond_with @subject
  end

  def create
    subject = current_user.subjects.new(subject_params)
    if subject.save
      respond_with :api, :v1, subject
    else
      respond_with subject
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :color)
  end

  def logged_in
    render json: 'Bad credentials', status: 401 unless current_user
  end
end
