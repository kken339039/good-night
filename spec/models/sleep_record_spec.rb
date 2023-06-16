require 'rails_helper'

RSpec.describe SleepRecord, type: :model do
  let(:user) { create(:user) }

  it "is valid with valid attributes" do
    model = described_class.new(
      user_id: user.id,
      check_in_at: DateTime.now,
      check_out_at: DateTime.now + 1.days,
      duration: 100.01
    )
    expect(model).to be_valid
  end

  context 'when active record already exist' do 
    let!(:record) { create(:sleep_record, user_id: user.id, status: 'active') }

    it "is non valid with status" do
      model = described_class.new(
        user_id: user.id,
        status: 'active',
        check_in_at: DateTime.now
      )
      expect(model).to_not be_valid
    end
  end

  it "belongs to user" do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end
end
