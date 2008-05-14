require File.dirname(__FILE__) + '/spec_helper.rb'

class MyFlickr
  include MiniFlickr::Base
end


describe MiniFlickr::Base,"Fetching a Flickr stream" do
  
  before(:each) do
    @api_key = 'your-api-key-here'
    @user_id = '96045892@N00'
    MyFlickr.connect_to_flickr(
      :api_key  => @api_key,
      :user_id  => @user_id
    )
    @flickr = MyFlickr.new
  end
  
  it "should have connection data at class level" do
    MyFlickr.flickr_api_data[:api_key].should == @api_key
    MyFlickr.flickr_api_data[:user_id].should == @user_id
  end
  
  it "should fetch recent photos" do
    @flickr.photos.should be_kind_of Array
    @flickr.photos.first.should be_kind_of MiniFlickr::Photo
  end
  
end
