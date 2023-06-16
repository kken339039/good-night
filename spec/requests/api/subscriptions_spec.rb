require 'rails_helper'

RSpec.describe "Api::Subscriptions", type: :request do
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
