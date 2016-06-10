json.array!(@schedules) do |schedule|
  json.extract! schedule, :id, :title, :schedule_on, :user_id
  json.url schedule_url(schedule, format: :json)
end
