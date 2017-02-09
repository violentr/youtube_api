require "youtube_connector_service"

class WelcomeController < ApplicationController

  def index
    api_key = APPCONFIG["youtube_key"]
    @items = YoutubeConnector.new(api_key).process
  end
end
