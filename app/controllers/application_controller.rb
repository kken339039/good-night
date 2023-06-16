class ApplicationController < ActionController::API
  attr_reader :current_user

  def set_current_user
    @current_user = User.find_by(id: params[:user_id])

    raise UserNotFoundError.new("Current user not found") if @current_user.nil?
  rescue UserNotFoundError => ex
    Rails.logger.error(ex.to_s)
    render json: ex.as_json, status: ex.status
  end

  class UserNotFoundError < ApplicationError
    def status
      :not_found
    end
  end
end
