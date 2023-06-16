class ApplicationController < ActionController::API
  attr_reader :current_user

  def set_current_user
    @current_user = User.find(params[:user_id])
  end
end
