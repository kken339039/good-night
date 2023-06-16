class Api::SleepRecordsController < ApplicationController
  before_action :set_current_user

  def check_in
    check_in_record = SleepRecord.create!(user_id: current_user.id, check_in_at: Time.now)
    render json: { result: "success" }, status: :ok
  rescue => ex
    Rails.logger.error(ex.to_s)
    error = SleepRecordsControllerError.new(ex.to_s)
    render json: error.as_json, status: error.status
  end

  class SleepRecordsControllerError < ApplicationError
    def status
      :unprocessable_entity
    end
  end
end
