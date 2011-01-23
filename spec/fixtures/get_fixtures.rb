%w{
    http://feeds.delicious.com/v2/xml/recent
    http://feeds.delicious.com/v2/xml/tag/django+python
    http://feeds.delicious.com/v2/xml/popular
    http://feeds.delicious.com/v2/xml/popular/lisp
    http://feeds.delicious.com/v2/xml/alerts
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
    %x{curl #{url} > #{url.gsub(/http:\/\/feeds\.delicious\.com\/v2\/(json|xml)\//, "").gsub(/\//, ".")}}
end
