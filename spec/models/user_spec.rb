require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    model = described_class.new(name: "user_001")
    expect(model).to be_valid
  end

  it "has many sleep_records" do
    association = described_class.reflect_on_association(:sleep_records)
    expect(association.macro).to eq(:has_many)
  end

  it "has many subscriptions" do
    association = described_class.reflect_on_association(:subscriptions)
    expect(association.macro).to eq(:has_many)
  end
end
