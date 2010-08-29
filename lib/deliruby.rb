require 'httparty'
require 'httparty_icebox'
#Abstract representation of a delicious bookmark item
class DeliciousBookmark
    #The bookmarked url
    attr_accessor :url
    #The tags applied to it in this instance
    attr_accessor :tags
    #The title of this bookmark
    attr_accessor :title
    #The date when the bookmark was made
    attr_accessor :published_on
    #Who bookmarked it
    attr_accessor :creator

    def initialize(url, title="", published_on=nil, creator="", tags=[])
        @url = url 
        @tags = tags || []
        @title = title || ""
        @published_on = published_on
        @creator = creator || ""
    end
    
    #convert this instance into a hash, based on 
    #{this snippet}[http://pullmonkey.com/2008/01/06/convert-a-ruby-hash-into-a-class-object/comment-page-1/]
    def to_hash
        hsh = {}
        self.instance_variables.each do |var| 
            hsh[var.gsub("@","")] = self.instance_variable_get(var)
        end
    end
end
#Provides instance methods to access the public feeds of delicious.com, returning an array of Bookmark instances 
class Deliruby
    include HTTParty
    include HTTParty::Icebox
    format :xml
    base_uri "http://feeds.delicious.com/v2/xml"
    cache :store => 'memory', :timeout => 1
    
    #base method for all the calls to the delicious api
    #Params
    def self.get_feed(url="/") 
        res = get(url)
        bookmarks = []
        res['rss']['channel']['item'].each do |item|
            bookmarks.push DeliciousBookmark.new(item['link'], item['title'], item['pubDate'], item['dc:creator'],
                                                 item['category'])
        end
        return bookmarks
    end
    class << self
        alias :popular :get_feed
    end
end
