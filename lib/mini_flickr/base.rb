module MiniFlickr
  module Base
    
    def self.included( base )
      base.send :include, InstanceMethods
      base.extend ClassMethods
    end
    
    
    module InstanceMethods
      
      # This is set to Flickr API data either from the conect_to_flickr class method
      # or MiniFlickr::Simple instances
      #
      attr_accessor :flickr_api_data
      
      # == Array of photos
      #
      def photos
        @photos ||= begin
          (doc/'photos'/'photo').collect do |photo|
            MiniFlickr::Photo.new( photo.attributes['id'], flickr_api_data[:api_key] )
          end
        end
      end
      
      
      protected
      
      def doc
        return @doc if @doc
        a, k = flickr_api_data[:api_key], flickr_api_data[:user_id]
        url = "http://api.flickr.com/services/rest/"
        url << "?method=flickr.people.getPublicPhotos&per_page=30&api_key=#{a}&user_id=#{k}"
        @doc = Hpricot(open( url ))
      end
      
    end
    
    module ClassMethods
      
      # Even though we set flickr api data at class-level, we store it in instance methods
      # so they can be overwritten per-instance
      #
      def connect_to_flickr(opts = {})
        class_eval %(
        def flickr_api_data
          @flickr_api_data = {
            :api_key => '#{opts[:api_key]}',
            :user_id => '#{opts[:user_id]}'
          }
        end
        )
      end
      
    end
    
  end
end