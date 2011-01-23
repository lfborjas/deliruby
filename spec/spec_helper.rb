$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'deliruby'
require 'fakeweb'

%w{
    http://feeds.delicious.com/v2/xml/recent
    http://feeds.delicious.com/v2/xml/tag/django+python
    http://feeds.delicious.com/v2/xml/popular
    http://feeds.delicious.com/v2/xml/popular/lisp
    http://feeds.delicious.com/v2/xml/lfborjas
    http://feeds.delicious.com/v2/xml/lfborjas/ruby+metaprogramming
    http://feeds.delicious.com/v2/xml/userinfo/lfborjas
    http://feeds.delicious.com/v2/xml/tags/lfborjas
    http://feeds.delicious.com/v2/xml/tags/lfborjas/scheme+functional-programming
    http://feeds.delicious.com/v2/xml/subscriptions/lfborjas
    http://feeds.delicious.com/v2/xml/network/lfborjas
    http://feeds.delicious.com/v2/xml/network/lfborjas/ruby+rails
    http://feeds.delicious.com/v2/xml/networkmembers/lfborjas
    http://feeds.delicious.com/v2/xml/networkfans/lfborjas
    http://feeds.delicious.com/v2/xml/url/cc152f3f73e89585684bee04f79ddc5d
    http://feeds.delicious.com/v2/json/urlinfo/cc152f3f73e89585684bee04f79ddc5d
}.each do |url|
   FakeWeb.register_uri(:get, url,
                        :body=> File.open("#{File.dirname(__FILE__)}/fixtures/#{
                                 url.gsub(/http:\/\/feeds\.delicious\.com\/v2\/(json|xml)\//, "").gsub(/\//, ".")
                                }").read)
end

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  
end
