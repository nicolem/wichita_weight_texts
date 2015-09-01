json.array!(@spanish_messages) do |spanish_message|
  json.extract! spanish_message, :id
  json.url spanish_message_url(spanish_message, format: :json)
end
