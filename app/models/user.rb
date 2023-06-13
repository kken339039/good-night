class User < ApplicationRecord
  # relations
  has_many :sleep_records

  # attributes
  attribute :name, :string

  # validation
end
