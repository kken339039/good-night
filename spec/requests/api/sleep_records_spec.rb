require 'rails_helper'

RSpec.describe "Api::SleepRecords", type: :request do
  describe "POST check_in" do
    let(:user){ create(:user) }

    it "success check in" do
      post "/api/#{user.id}/sleep_records/check_in"

      expect(response).to have_http_status(200)
      expect(response.body).to eq({"result": "success"}.to_json)
    end

    context 'when active record already exist' do
      let!(:record) { create(:sleep_record, user_id: user.id, status: 'active') }
      it "failed check in" do
        post "/api/#{user.id}/sleep_records/check_in"

        expect(response).to have_http_status(422)
        expect(response.body).to eq({"error_message": "Validation failed: Status active record can only exist at a time"}.to_json)
      end
    end
  end
end
