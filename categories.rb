

require 'rubygems'
require 'nokogiri' 
require 'crack'
require 'open-uri'
require 'rest-client'
MATHWIKI_URL = "http://en.wikipedia.org/wiki/Mathematics"
READWIKI_URL = "http://en.wikipedia.org/wiki/Reading_(visual_activity)"

page = Nokogiri::HTML(open(MATHWIKI_URL))
math_links = page.css("div#mw-content-text p")

page = Nokogiri::HTML(open(READWIKI_URL))
read_links = page.css("div#mw-content-text p")


#puts page.css("title")[0].name   # => title
#puts page.css("title")[0].text   # => My webpage  @doc.concat Crack::JSON.parse(resp)
puts math_links[0].text



