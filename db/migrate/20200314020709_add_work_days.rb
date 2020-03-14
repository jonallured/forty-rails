class AddWorkDays < ActiveRecord::Migration[6.0]
  def change
    create_table :work_days do |t|
      t.belongs_to :user
      t.date :date, null: false
      t.integer :adjust_minutes, default: 0, null: false
      t.integer :in_minutes, default: 0, null: false
      t.integer :out_minutes, default: 0, null: false
      t.integer :pto_minutes, default: 0, null: false
      t.timestamps
    end

    add_index :work_days, %i[date user_id], unique: true
  end
end
