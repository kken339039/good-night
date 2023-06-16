FactoryGirl.define do
  factory :sleep_record do
    check_in_at Time.now
    status 'active'
  end
end