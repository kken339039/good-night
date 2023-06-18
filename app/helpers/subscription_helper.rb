module SubscriptionHelper
  def render_sorted_records(sleep_records)
    sleep_records = sleep_records.sort_by { |_, total| -total }.to_h
    sleep_records.each_with_object({}) do |(name, total_seconds), hash|
      hours = total_seconds / 3600
      minutes = (total_seconds % 3600) / 60
      seconds = total_seconds % 60
      hash[name] = "#{hours.to_i}hours #{minutes.to_i}minutes #{seconds.to_i}seconds"
    end
  end
end