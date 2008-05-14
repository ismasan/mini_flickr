$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'open-uri'
require 'rubygems'
require 'hpricot'

Dir.glob(File.join(File.dirname(__FILE__),'mini_flickr','*.rb')).each {|f| require f}

module MiniFlickr
  
end