json.array!(@reminders) do |reminder|
  json.extract! reminder, :id, :title, :note, :schedule_on
  json.url reminder_url(reminder, format: :json)
end
