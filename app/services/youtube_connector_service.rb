class YoutubeConnector
  attr_reader :channel_id, :size, :api_key

  def initialize(api_key, size=20, channel_id="")
    @api_key = api_key
    @size = size
    @channel_id ||= "UCVguiojKA6iobcySMJ5boNA"
  end

  def process
    get_data(url)
  end

  private

  def url
    URI("https://www.googleapis.com/youtube/v3/search?key=#{api_key}&channelId
              =#{channel_id}&part=snippet,id&order=date&maxResults=#{size}")
  end

  def error
    {error: "bad data, possible you have no API key set"}
  end

  def get_data(url)
    response = Net::HTTP.get_response(url)
    return error unless response.code == "200"
    JSON.parse(response.body).fetch("items")
  end

end
