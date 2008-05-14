module MiniFlickr
  # A flickr photo.
  #
  class Photo
    
    def initialize(id, api_key)
      @id, @api_key = id, api_key
    end
    
    %w(Square Thumbnail Small Medium Original).each do |size|
      class_eval %(
      def #{size.downcase}
        @#{size.downcase} ||= source('#{size}')
      end
      
      def #{size.downcase}_url
        @#{size.downcase}_url ||= url_for('#{size}')
      end
      )
    end
    
    protected
    
    def source(size = "small")
      sizes.search("//size[@label='#{size}']").first.attributes['source']
    end
    
    def url_for(size = 'small')
      sizes.search("//size[@label='#{size}']").first.attributes['url']
    end
    
    def sizes
      url = "http://api.flickr.com/services/rest/"
      url << "?method=flickr.photos.getSizes&api_key=#{@api_key}&photo_id=#{@id}"
      @sizes ||= begin
        Hpricot(open( url ))
      end
    end
    
  end
end