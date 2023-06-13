class Subscription < ApplicationRecord
  # relations
  belongs_to :user, class_name: "User", foreign_key: :user_id
  belongs_to :target_user, class_name: "User", foreign_key: :target_user_id

  # attributes
  attribute :actived_at, :datetime

  # validation
end
