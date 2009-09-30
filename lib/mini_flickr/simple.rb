module MiniFlickr
  # This class is meant to load api_key and user_id per instance instead of at class-level
  #
  # Example:
  # flickr = MiniFlickr::Simple.new(api_key, user_id)
  # flickr.photos
  #
  # Or as a value object in ActiveRecord
  #
  # class Flickr < MiniFlickr::Simple; end
  #
  # composed_of :flickr, :mappings => %w(api_key user_id)
  #
  class Simple
    include Base
    
    def initialize(api_key, user_id)
      @flickr_api_data = {
        :api_key => api_key,
        :user_id => user_id
      }
    end
    
  end
  
end