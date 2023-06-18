class Api::SleepRecordsController < ApplicationController
  before_action :set_current_user

  def check_in
    check_in_record = SleepRecord.create!(user_id: current_user.id, check_in_at: Time.now, status: 'active')

    before_records = SleepRecord.where(user_id: current_user.id).order(created_at: :desc)
    render json: before_records.as_json, status: :ok
  rescue => ex
    Rails.logger.error(ex.to_s)
    error = SleepRecordsControllerError.new(ex.to_s)
    render json: error.as_json, status: error.status
  end

  def check_out
    check_in_record = SleepRecord.find_by(user_id: current_user.id, check_out_at: nil)
    raise CheckInRecordNotFoundError.new("Cannot Found check in record") if check_in_record.nil?

    check_out_at = Time.now
    duration = check_out_at - check_in_record.check_in_at
    check_in_record.update!(check_out_at: check_out_at, duration: duration, status: 'check_out')

    render json: { result: "success" }, status: :ok
  rescue CheckInRecordNotFoundError => ex
    Rails.logger.error(ex.to_s)
    render json: ex.as_json, status: ex.status
  rescue => ex
    Rails.logger.error(ex.to_s)
    error = SleepRecordsControllerError.new(ex.to_s)
    render json: error.as_json, status: error.status
  end

  class CheckInRecordNotFoundError < ApplicationError
    def status
      :not_found
    end
  end

  class SleepRecordsControllerError < ApplicationError
    def status
      :unprocessable_entity
    end
  end
end
