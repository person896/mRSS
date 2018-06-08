json.extract! meeting, :id, :name, :description, :room_id, :date, :time_start, :time_end, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)