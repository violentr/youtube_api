RSpec.describe YoutubeConnector do
  before do
    api = "your_api_key_here"
    @connect = YoutubeConnector.new(api)
  end

  def stub_local_request(output)
    allow_any_instance_of(described_class).to receive(:process)
      .and_return(output)
    stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId%20%20%20%20%20%20%20%20%20%20%20%20%20%20=UCVguiojKA6iobcySMJ5boNA&key=your_api_key_here&maxResults=20&order=date&part=snippet,id").
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'www.googleapis.com', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => output , :headers => {})
  end

  context 'when Api key is provided' do
    it "should be an instance of #{described_class}" do
      expect(@connect).to be_an_instance_of(described_class)
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
    it 'should respond with array of data' do
      stub_local_request([])
      expect(@connect.process).to be_kind_of(Array)
    end
    xit 'should have size' do
      expect(@connect.size).to eq 20
    end
    context 'when Api key is wrong' do
      it 'should have Api key' do
        expect(@connect.api_key).to be
      end
      it 'should have error message' do
        stub_request(:get, "https://www.googleapis.com/youtube/v3/search?channelId%20%20%20%20%20%20%20%20%20%20%20%20%20%20=UCVguiojKA6iobcySMJ5boNA&key=your_api_key_here&maxResults=20&order=date&part=snippet,id").
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'www.googleapis.com', 'User-Agent'=>'Ruby'}).
          to_return(:status => 400, :body => "", :headers => {})
        error = {error: "bad data, possible you have no API key set"}
        expect(@connect.process).to eq error
      end
    end
  end
end
