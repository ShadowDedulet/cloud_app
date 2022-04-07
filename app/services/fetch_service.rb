require 'uri'
require 'open-uri'

# Service providing method for fetching data using uri
module FetchService
  def self.fetch(url, query_h = nil)
    uri = URI.parse(url)
    uri.query = URI.encode_www_form(query_h) if query_h
    puts(">>Fetching from #{url}...")
    open(uri, &:read)
  end
end
