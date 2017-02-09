class YoutubeConnector
  attr_reader :channel_id, :size, :api_key

  def initialize(api_key, size=20, channel_id="")
    @api_key = api_key
    @size = size
    @channel_id ||= "UCVguiojKA6iobcySMJ5boNA"
  end

end
