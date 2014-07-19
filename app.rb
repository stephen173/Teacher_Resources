require 'sinatra'
require 'nokogiri' 
require 'rubygems'
require 'crack'
require 'open-uri'
require 'rest-client'
MATHWIKI_URL = "http://en.wikipedia.org/wiki/Mathematics"
READWIKI_URL = "http://en.wikipedia.org/wiki/Reading_(visual_activity)"
MATH2PAGE_URL = "http://www.testprepreview.com/math-grade-2.htm"
MATH3PAGE_URL = "http://www.testprepreview.com/math-grade-3.htm"
MATH4PAGE_URL = "http://www.testprepreview.com/math-grade-4.htm"

READ2PAGE_URL = "http://www.testprepreview.com/ela-grade-2.htm"
READ3PAGE_URL = "http://www.testprepreview.com/ela-grade-3.htm"
READ4PAGE_URL = "http://www.testprepreview.com/ela-grade-4.htm"


  set :bind, '0.0.0.0'
  set :port, 3000


get '/math.erb' do
resp = RestClient.get('http://en.wikipedia.org/w/api.php?action=opensearch&search=')
doc = JSON.parse(resp)
@doc = []
  erb :math
end

get '/reading.erb' do
resp = RestClient.get('http://en.wikipedia.org/w/api.php?action=opensearch&search=')
doc = JSON.parse(resp)
@doc = []
  erb :reading
end

#puts page.css("title")[0].name   # => title
#puts page.css("title")[0].text   # => My webpage  @doc.concat Crack::JSON.parse(resp)
get '/' do 
resp = RestClient.get('http://en.wikipedia.org/w/api.php?action=opensearch&search=')
doc = JSON.parse(resp)
@doc = []
  erb :home
end

get '/category' do
    @channel = params['category']
    @subject = []
    @math = []
    @reading = []
    page = Nokogiri::HTML(open(MATHWIKI_URL))
    @math_links = page.css("div#mw-content-text p")
    page_2 = Nokogiri::HTML(open(READWIKI_URL))
    @read_links = page_2.css("div#mw-content-text p")

    if @channel == "Choose One"
        @subject = []
      elsif @channel == "Math"
        @channel = "Math"
      elsif @channel == "Reading"
        @reading << @subject
    end
  erb :home
end

get '/subcategory' do
  @mchannel = params['subcategory']
    page3 = Nokogiri::HTML(open(MATH2PAGE_URL))
  @math2_links = page3.css('p')
    page4 = Nokogiri::HTML(open(MATH3PAGE_URL))
  @math3_links = page4.css('p')
    page5 = Nokogiri::HTML(open(MATH4PAGE_URL))
  @math4_links = page5.css('p')
    erb :math
end

get '/readcategory' do
  @rchannel = params['readcategory']
    read2 = Nokogiri::HTML(open(READ2PAGE_URL))
  @read2_links = read2.css('p')
    read3 = Nokogiri::HTML(open(READ3PAGE_URL))
  @read3_links = read3.css('p')
    read4 = Nokogiri::HTML(open(READ4PAGE_URL))
  @read4_links = read4.css('p')
    erb :reading
end


