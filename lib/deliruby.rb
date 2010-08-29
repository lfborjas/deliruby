require 'httparty'
require 'httparty_icebox'
require 'date'
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
        @published_on = published_on ? DateTime.strptime(published_on, "%a, %d %b %Y %H:%M:%S %Z") : nil
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
class Bookmarks 
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

    def self.recent
        return self.get_feed('/recent')
    end

    def self.by_tags(tags=[])        
        return self.get_feed("/tag/#{tags.join('+')}")
    end

    def self.popular(tag="")
        return self.get_feed("/popular#{"/"+tag if tag}")
    end

    def self.for_user(user, tags=[])
        return self.get_feed("/#{user}/#{tags.join('+')}")
    end
    def self.subscripted(user)
        return self.get_feed("/subscriptions/#{user}")
    end
    def self.network(user, tags=[])
        return self.get_feed("/network/#{user}/#{tags.join('+')}")
    end
    def self.for_url(url)
        return self.get_feed("/url/#{Digest::MD5.hexdigest(url)}")
    end
    class << self
        alias :hotlist :get_feed
        alias :tagged :by_tags
        alias :for :for_user
        alias :for_network :network
        alias :for_subscriptions :subscripted
    end
end
