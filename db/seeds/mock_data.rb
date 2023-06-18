# mock users
user_1 = User.create!(name: "test_user1")
user_2 =  User.create!(name: "test_user2")
user_3 = User.create!(name: "test_user4")
user_4 = User.create!(name: "test_user3")
user_5 = User.create!(name: "test_user5")

# mock subscriptions
# user_1
Subscription.create!(user_id: user_1.id, target_user_id: user_2.id, actived_at: Time.now)
Subscription.create!(user_id: user_1.id, target_user_id: user_3.id, actived_at: Time.now)
Subscription.create!(user_id: user_1.id, target_user_id: user_4.id, actived_at: Time.now)
Subscription.create!(user_id: user_1.id, target_user_id: user_5.id, actived_at: nil)

# user_2
Subscription.create!(user_id: user_2.id, target_user_id: user_1.id, actived_at: Time.now)
Subscription.create!(user_id: user_2.id, target_user_id: user_3.id, actived_at: nil)
Subscription.create!(user_id: user_2.id, target_user_id: user_4.id, actived_at: Time.now)
Subscription.create!(user_id: user_2.id, target_user_id: user_5.id, actived_at: Time.now)

# mock sleep_records
SleepRecord.create!(user_id: user_1.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_2.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_3.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_4.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_5.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_1.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_2.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_3.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_4.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_5.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_1.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_2.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_3.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_4.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_5.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_1.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_2.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_3.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_4.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_5.id, status: 'check_out', check_in_at: (Time.now - rand(0..7).days), duration: rand(7000..30000))

# over 7 days records
SleepRecord.create!(user_id: user_1.id, status: 'check_out', check_in_at: (Time.now - rand(8..15).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_2.id, status: 'check_out', check_in_at: (Time.now - rand(8..15).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_3.id, status: 'check_out', check_in_at: (Time.now - rand(8..15).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_4.id, status: 'check_out', check_in_at: (Time.now - rand(8..15).days), duration: rand(7000..30000))
SleepRecord.create!(user_id: user_5.id, status: 'check_out', check_in_at: (Time.now - rand(8..15).days), duration: rand(7000..30000))
