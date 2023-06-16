class SleepRecord < ApplicationRecord
  # relations
  belongs_to :user

  # attributes
  attribute :check_in_at, :datetime
  attribute :check_out_at, :datetime
  attribute :status, :string, default: 'active'
  attribute :duration, :float, default: 0

  # validation
  validates_inclusion_of :status, in: %w(active removed check_out), message: "status %{value} is not valid"
  validate :valid_only_one_active

  def valid_only_one_active
    active_records = SleepRecord.where(user_id: self.user_id, status: 'active')
    errors.add(:status, "active record can only exist at a time") if active_records.present?
  end
end
