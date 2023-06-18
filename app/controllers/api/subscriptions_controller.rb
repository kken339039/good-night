class Api::SubscriptionsController < ApplicationController
  include ::SubscriptionHelper

  before_action :set_current_user
  before_action :set_target_user, only: %i(activate deactivate)
  before_action :set_subscription, only: %i(activate deactivate)

  def index
    end_date = Time.now.beginning_of_day
    start_date = end_date - 7.days

    target_user_ids = Subscription.where(user_id: current_user.id).pluck(:target_user_id)
    sleep_records = SleepRecord.joins(:user)
                               .where('sleep_records.user_id': target_user_ids)
                               .where('sleep_records.check_in_at': start_date..end_date)
                               .group('users.id')
                               .select('users.name, SUM(sleep_records.duration) AS total_duration')
                               .pluck('users.name, SUM(sleep_records.duration)')

    render json: render_sorted_records(sleep_records), status: :ok
  rescue => ex
    Rails.logger.error(ex.to_s)
    error = SubscriptionsControllerError.new(ex.to_s)
    render json: error.as_json, status: error.status
  end

  def activate
    raise UserNotFoundError.new("Subscribed User Not Found") if @target_user.nil?
    @subscription.actived_at = Time.now
    @subscription.save!

    render json: { result: "success" }, status: :ok
  rescue UserNotFoundError => ex
    Rails.logger.error(ex.to_s)
    render json: ex.as_json, status: ex.status
  rescue => ex
    Rails.logger.error(ex.to_s)
    error = SubscriptionsControllerError.new(ex.to_s)
    render json: error.as_json, status: error.status
  end

  def deactivate
    raise UserNotFoundError.new("Subscribed User Not Found") if @target_user.nil?
    @subscription.actived_at = nil
    @subscription.save!

    render json: { result: "success" }, status: :ok
  rescue UserNotFoundError => ex
    Rails.logger.error(ex.to_s)
    render json: ex.as_json, status: ex.status
  rescue => ex
    Rails.logger.error(ex.to_s)
    error = SubscriptionsControllerError.new(ex.to_s)
    render json: error.as_json, status: error.status
  end

  private

  def set_target_user
    @target_user = User.find_by(id: subscribe_params[:target_user_id])
  end

  def set_subscription
    return nil if @target_user.nil?

    @subscription = Subscription.find_or_initialize_by(user_id: current_user.id, target_user_id: @target_user.id)
  end

  def subscribe_params
    params.permit(:user_id, :target_user_id)
  end

  class SubscriptionsControllerError < ApplicationError
    def status
      :unprocessable_entity
    end
  end
end
