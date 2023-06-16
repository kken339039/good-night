class SleepRecordAddStatusAndIndex < ActiveRecord::Migration[7.0]
  def change
    add_column :sleep_records, :status, :string

    add_index(:sleep_records, [:user_id, :status])
    add_index(:sleep_records, [:user_id, :duration])
  end
end
