module ApplicationHelper
  def send_get(endpoint = "/")
    return response = HTTParty.get(
        "#{ENV["REUNI_HOST"]}#{endpoint}",
        :headers => {
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer #{cookies[:token]}"
    }
    )
  end
end
