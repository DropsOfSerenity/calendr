class ApplicationController < ActionController::Base
  respond_to :json, :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
  end

  def trigger_user_pusher_action(action, id)
      Pusher.trigger("private-calendr-#{current_user.id}", action, {id: id})
  end
end
