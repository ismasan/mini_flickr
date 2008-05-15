= mini_flickr

* http://github.com/ismasan/mini_flickr/tree/master

== DESCRIPTION:

Simple gem to fetch your Flickr photos through Flickr's REST API

Get your Flickr API_KEY at http://www.flickr.com/services/api/keys/

Get your Flickr user id at http://idgettr.com/

== FEATURES/PROBLEMS:

* For now it just fetches the latest 30 photos

* This is not meant to upload photos to Flickr

== SYNOPSIS:

=== Class level configuration

  class MyFlickr
    include MiniFlickr::Base
    connect_to_flickr :api_key => 'your-api-key', :user_id => 'your-user-id'
  end

  flickr = MyFlickr.new

  <% flickr.photos.each do |photo| %>
	<a href="<%= photo.medium_url %>">
		<img src="<%= photo.small %>" />
	</a>
  <% end %>

=== Instance level configuration

There's also a utility class that takes api_key and user_id as parameters.
This means you can configure Flickr accounts per-instance (for example your site has many users, each with their own Flickr photos).

flickr = MiniFlickr::Simple.new('some-key', 'some-user-id')

flickr.photos # => collection of MiniFlickr::Photo objects with sizes and url's (see above)

You can also use this as a value object for ActiveRecord, for example.

class Flickr < MiniFlickr::Simple; end

class User < ActiveRecord::Base
	composed_of :flickr, :mappings => %w(api_key flickr_user_id)
end

user = User.create(:name => 'Ismael', :api_key => 'some-api-key', :flickr_user_id => 'some-flickr-userid')

user.flickr.photos # collection of flickr photos

== TESTING:

This gem uses Rspec for testing. Run the existing specs with rake spec.

You'll need to add your own API key in order for the test suite to work.

Do so by storing it in a file called/api_key.txt

If you contribute, please write specs and make sure they pass.

=== Each photo has:

==== Source image urls for sizes

photo.square

photo.thumbnail

photo.small

photo.medium

photo.original

==== Page urls for sizes

photo.square_url

photo.thumbnail_url

photo.small_url

photo.medium_url

photo.original_url

== REQUIREMENTS:

* Hpricot (sudo gem install hpricot)

== INSTALL:

* git clone git://github.com/ismasan/mini_flickr.git

* cd mini_flickr

* rake install_gem

== LICENSE:

(The MIT License)

Copyright (c) 2008 Ismael Celis

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.