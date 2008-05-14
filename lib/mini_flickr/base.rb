module MiniFlickr
  module Base
    
    def self.included( base )
      base.send :include, InstanceMethods
      base.extend ClassMethods
    end
    
    
    module InstanceMethods
      
      # == Array of photos
      #
      def photos
        @photos ||= begin
          (doc/'photos'/'photo').collect do |photo|
            MiniFlickr::Photo.new( photo.attributes['id'], self.class.flickr_api_data[:api_key] )
          end
        end
      end
      
      
      protected
      
      def doc
        return @doc if @doc
        a, k = self.class.flickr_api_data[:api_key], self.class.flickr_api_data[:user_id]
        url = "http://api.flickr.com/services/rest/"
        url << "?method=flickr.people.getPublicPhotos&per_page=30&api_key=#{a}&user_id=#{k}"
        @doc = Hpricot(open( url ))
      end
      
    end
    
    module ClassMethods
      
      attr_accessor :flickr_api_data
      
      def connect_to_flickr(opts = {})
        @flickr_api_data ||= opts
      end
      
    end
    
  end
end