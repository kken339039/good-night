require 'rails_helper'

RSpec.describe "Api::SleepRecords", type: :request do
  describe "POST check_in" do
    let(:user){ create(:user) }

    it "success check in" do
      expect {
        post "/api/#{user.id}/sleep_records/check_in"
      }.to change(user.sleep_records, :count).by(1)

      expect(response).to have_http_status(200)
    end

    context 'when check in has older data' do
      let!(:record) { create(:sleep_record, user_id: user.id, status: 'check_out', check_out_at: Time.now) }
      it "success check in" do
        expect {
          post "/api/#{user.id}/sleep_records/check_in"
        }.to change(user.sleep_records, :count).by(1)

        response_body = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(response_body.count).to eq(2)
        expect(response_body.last['id']).to eq(record.id)
      end
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

  describe "POST check_out" do
    let(:user){ create(:user) }
    let!(:record) { create(:sleep_record, user_id: user.id, status: 'active', check_in_at: Time.now) }

    it "success check out" do
      post "/api/#{user.id}/sleep_records/check_out"

      expect(response).to have_http_status(200)
      expect(response.body).to eq({"result": "success"}.to_json)
    end

    context 'when active record not exist' do
      let!(:record) { nil }

      it "failed check out" do
        post "/api/#{user.id}/sleep_records/check_out"

        expect(response).to have_http_status(404)
        expect(response.body).to eq({"error_message": "Cannot Found check in record"}.to_json)
      end
    end

    context 'when update record failed' do
      it "failed check out" do
        allow_any_instance_of(SleepRecord).to receive(:update!).and_raise("It has some error")
        post "/api/#{user.id}/sleep_records/check_out"
        expect(response).to have_http_status(422)
        expect(response.body).to eq({"error_message": "It has some error"}.to_json)
      end
    end
  end
end
