class CreateMeetings < ActiveRecord::Migration[5.0]
  def change
    create_table :meetings do |t|
      t.string :name
      t.text :description
      t.integer :room_id
      t.date :date
      t.time :time_start
      t.time :time_end

      t.timestamps
    end
  end
end
