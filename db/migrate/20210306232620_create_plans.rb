class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.string :title
      t.integer :creator_id
      t.string :location
      t.string :time
      t.string :status

      t.timestamps
    end
  end
end
