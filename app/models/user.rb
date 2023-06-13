class User < ApplicationRecord
  # relations
  has_many :sleep_records
  has_many :subscriptions

  # attributes
  attribute :name, :string

  # validation
end
