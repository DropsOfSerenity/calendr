class Api::V1::SubjectController < ApplicationController
  def index
    @subjects = current_user.subjects
    respond_with @subjects
  end

  def show
    @subject = Subject.find(params[:id])
    respond_with @subject
  end
end
