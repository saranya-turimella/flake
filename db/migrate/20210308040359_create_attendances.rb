class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
      t.integer :user_id
      t.integer :plan_id
      t.boolean :flake
      t.boolean :pending
      t.boolean :attending

      t.timestamps
    end
  end
end
