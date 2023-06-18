module SubscriptionHelper
  def render_sorted_records(sleep_records)
    sleep_records.sort_by { |_, total| -total }.to_h
  end
end