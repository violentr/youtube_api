RSpec.describe YoutubeConnector do
  before do
    api = "yout Api key here"
    @connect = YoutubeConnector.new(api)
  end

   it 'should have Api key' do
     expect(@connect.api_key).to be
   end
   it 'should have size' do
     expect(@connect.size).to eq 20
   end
   it 'should have channel_id' do
     expect(@connect.channel_id).to be
   end
end
