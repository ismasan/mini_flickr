require File.dirname(__FILE__) + '/spec_helper.rb'

class MyFlickr
  include MiniFlickr::Base
end

API_KEY = File.read(File.dirname(__FILE__) + '/api_key.txt')#'your-api-key-here'
USER_ID = '96045892@N00'

describe MiniFlickr::Base,"Fetching a Flickr stream" do
  
  before(:each) do
    MyFlickr.connect_to_flickr(
      :api_key  => API_KEY,
      :user_id  => USER_ID
    )
    @flickr = MyFlickr.new
  end
  
  it "should have connection data at instance level" do
    @flickr.flickr_api_data[:api_key].should == API_KEY
    @flickr.flickr_api_data[:user_id].should == USER_ID
  end
  
  it "should fetch recent photos" do
    @flickr.photos.should be_kind_of Array
    @flickr.photos.first.should be_kind_of MiniFlickr::Photo
    puts "#{@flickr.photos.first.small} => #{@flickr.photos.first.small_url}"
  end
  
end

describe MiniFlickr::Simple,"Instantiating the class" do
  before(:each) do
    @flickr = MiniFlickr::Simple.new(API_KEY, USER_ID)
  end
  
  it "should fetch photos" do
    @flickr.photos.should be_kind_of Array
    @flickr.photos.first.should be_kind_of MiniFlickr::Photo
    puts "#{@flickr.photos.first.small} => #{@flickr.photos.first.small_url}"
  end
end
