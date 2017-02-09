class YoutubeConnector
  attr_reader :channel_id, :size, :api_key

  def initialize(api_key, channel_id=nil, size=20)
    @api_key = api_key
    @channel_id = channel_id || "UCVguiojKA6iobcySMJ5boNA"
    @size = size
  end

  def process
    data = get_data(url)
    format_for_frontend(data)
  end

  private

  def url
    URI("https://www.googleapis.com/youtube/v3/search?key=#{api_key}&channelId=#{channel_id}&part=snippet,id&order=date&maxResults=#{size}")
  end

  def error
    {error: "bad data, possible you have no API key set"}
  end

  def get_data(url)
    response = Net::HTTP.get_response(url)
    return error unless response.code == "200"
    JSON.parse(response.body).fetch("items")
  end

  def format_for_frontend(data)
    return data unless data.is_a?(Array)
    data.each_with_object([]) do |item, array|
      item = item.reject {|key, value| key != "snippet" }
      options = item.dig("snippet", "thumbnails", "high")
      item["snippet"]["thumbnails"] = options
      array << item
    end
  end
end
