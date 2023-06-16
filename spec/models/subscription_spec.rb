require 'rails_helper'

RSpec.describe Subscription, type: :model do
  let(:user) { create(:user) }
  let(:target_user) { create(:user) }

  it "is valid with valid attributes" do
    model = described_class.new(
      user_id: user.id,
      target_user_id: target_user.id,
      actived_at: DateTime.now
    )
    expect(model).to be_valid
  end

   it "belongs to user" do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end

   it "belongs to target_user" do
    association = described_class.reflect_on_association(:target_user)
    expect(association.macro).to eq(:belongs_to)
  end
end
