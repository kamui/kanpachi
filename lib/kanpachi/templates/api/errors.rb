api 'MyAPI' do
  error :malformed_params do
    description 'Sending invalid JSON will result in a 400 Bad Request response.'

    response do
      status 400
      header 'Content-Type', 'application/json'
      representation do
        property :message, type: String
      end
    end
  end
end
