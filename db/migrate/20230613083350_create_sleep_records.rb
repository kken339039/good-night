class CreateSleepRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :sleep_records do |t|
      t.references :user

      t.datetime :check_in_at
      t.datetime :check_out_at
      t.float :duration

      t.timestamps
    end

    add_index(:sleep_records, [:user_id, :created_at])
  end
end
