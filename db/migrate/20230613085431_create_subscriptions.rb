class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.references :user
      t.references :target_user

      t.datetime :actived_at

      t.timestamps
    end
  end
end
