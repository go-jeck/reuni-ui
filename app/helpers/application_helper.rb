module ApplicationHelper
  def send_get(endpoint = "/")
    return response = HTTParty.get(
        "#{ENV["REUNI_HOST"]}#{endpoint}",
        :headers => {
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer #{cookies[:token]}",
        }
    )
  end

  def send_post(endpoint = "/", body)
    return response = HTTParty.post(
      "#{ENV["REUNI_HOST"]}#{endpoint}",
      :headers => {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{cookies[:token]}",
      },
      :body => body
    )
  end
end
