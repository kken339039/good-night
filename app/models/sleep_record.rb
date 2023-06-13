class SleepRecord < ApplicationRecord
  # relations
  belongs_to :user

  # attributes
  attribute :check_in_at, :datetime
  attribute :check_out_at, :datetime
  attribute :duration, :float, default: 0

  # validation
end
