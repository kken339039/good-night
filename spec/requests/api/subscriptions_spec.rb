require 'rails_helper'

RSpec.describe "Api::Subscriptions", type: :request do
  describe "GET index" do
    let!(:user1){ create(:user, name: "user1") }
    let!(:user2){ create(:user, name: "user2") }
    let!(:user3){ create(:user, name: "user3") }

    let!(:subscription1){ create(:subscription, user_id: user1.id, target_user_id: user2.id) }
    let!(:subscription2){ create(:subscription, user_id: user1.id, target_user_id: user3.id) }

    let!(:sleep_record1){ create(:sleep_record, user_id: user2.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), check_out_at: Time.now, duration: 5000) }
    let!(:sleep_record2){ create(:sleep_record, user_id: user2.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), check_out_at: Time.now, duration: 6000) }
    let!(:sleep_record3){ create(:sleep_record, user_id: user2.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), check_out_at: Time.now, duration: 7000) }
    let!(:sleep_record4){ create(:sleep_record, user_id: user3.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), check_out_at: Time.now, duration: 15000) }
    let!(:sleep_record5){ create(:sleep_record, user_id: user3.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), check_out_at: Time.now, duration: 20000) }
    let!(:sleep_record6){ create(:sleep_record, user_id: user3.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), check_out_at: Time.now, duration: 25000) }

    it "success get subscriptions" do
      get "/api/#{user1.id}/subscriptions"

      response_body = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(response_body.first[0]).to eq(user3.name)
    end

    context 'when user not have subscription' do
      it "success get empty subscriptions" do
        get "/api/#{user3.id}/subscriptions"

        expect(response).to have_http_status(200)
        expect(response.body).to eq("{}")
      end
    end

    context 'when record all over 7 days ago' do
      let!(:user4){ create(:user, name: "user4") }
      let!(:subscription2){ create(:subscription, user_id: user2.id, target_user_id: user4.id) }

      let!(:not_range_record){ create(:sleep_record, user_id: user4.id, status: 'check_out', check_in_at: (Time.now - 8.days), check_out_at: Time.now, duration: 5000) }

      it "success get empty subscriptions" do
        get "/api/#{user2.id}/subscriptions"

        expect(response).to have_http_status(200)
        expect(response.body).to eq("{}")
      end
    end
  end

  describe "POST activate" do
    let(:user){ create(:user) }
    let(:target_user){ create(:user) }

    it "success activate" do
      post "/api/#{user.id}/subscriptions/activate", params: { target_user_id: target_user.id }

      subscription = Subscription.find_by(user_id: user.id, target_user: target_user.id)
      expect(response).to have_http_status(200)
      expect(response.body).to eq({"result": "success"}.to_json)
      expect(subscription.actived_at).to_not be_nil
    end

    context 'when current user not exist' do
      it "failed activate" do
        post "/api/0/subscriptions/activate", params: { target_user_id: nil }

        expect(response).to have_http_status(404)
        expect(response.body).to eq({"error_message": "Current User Not Found"}.to_json)
      end
    end

    context 'when target user not exist' do
      it "failed activate" do
        post "/api/#{user.id}/subscriptions/activate", params: { target_user_id: nil }

        expect(response).to have_http_status(404)
        expect(response.body).to eq({"error_message": "Subscribed User Not Found"}.to_json)
      end
    end

    context 'when activate subscription failed' do
      it "activate failed" do
        allow_any_instance_of(Subscription).to receive(:save!).and_raise("It has some error")
        post "/api/#{user.id}/subscriptions/activate", params: { target_user_id: target_user.id }\

        expect(response).to have_http_status(422)
        expect(response.body).to eq({"error_message": "It has some error"}.to_json)
      end
    end
  end

  describe "POST deactivate" do
    let(:user){ create(:user) }
    let(:target_user){ create(:user) }

    it "success deactivate" do
      post "/api/#{user.id}/subscriptions/deactivate", params: { target_user_id: target_user.id }

      subscription = Subscription.find_by(user_id: user.id, target_user: target_user.id)
      expect(response).to have_http_status(200)
      expect(response.body).to eq({"result": "success"}.to_json)
      expect(subscription.actived_at).to be_nil
    end

    context 'when current user not exist' do
      it "failed deactivate" do
        post "/api/0/subscriptions/deactivate", params: { target_user_id: nil }

        expect(response).to have_http_status(404)
        expect(response.body).to eq({"error_message": "Current User Not Found"}.to_json)
      end
    end

    context 'when target user not exist' do
      it "failed deactivate" do
        post "/api/#{user.id}/subscriptions/deactivate", params: { target_user_id: nil }

        expect(response).to have_http_status(404)
        expect(response.body).to eq({"error_message": "Subscribed User Not Found"}.to_json)
      end
    end

    context 'when deactivate subscription failed' do
      it "deactivate failed" do
        allow_any_instance_of(Subscription).to receive(:save!).and_raise("It has some error")
        post "/api/#{user.id}/subscriptions/deactivate", params: { target_user_id: target_user.id }\

        expect(response).to have_http_status(422)
        expect(response.body).to eq({"error_message": "It has some error"}.to_json)
      end
    end
  end
end
