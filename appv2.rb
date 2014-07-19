require 'sinatra'
require 'nokogiri' 
require 'rubygems'
require 'crack'
require 'open-uri'
require 'rest-client'
WURL = 'http://en.wikipedia.org/w/api.php?action=opensearch&search='
WURL2 = '&namespace=0&suggest='

  set :bind, '0.0.0.0'
  set :port, 3000

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
    resp = RestClient.get("#{WURL}#{@channel}#{WURL2}", 'User-Agent' => 'Ruby')
    @subject.concat Crack::JSON.parse(resp)
    if @channel == "Choose One"
        @subject = []
      elsif @channel == "Math"
        @math << @subject
            
    elsif @channel == "Reading"
        @reading << @subject
    end
  erb :home
end

if @channel == "Math"
get '/subcategory' do
  @mathcat = []
value = "math"  
resp = RestClient.get("#{WURL}#{value}#{WURL2}", 'User-Agent' => 'Ruby')
  @doc.concat Crack::JSON.parse(resp)
  puts @doc.class
  @channel = value
    erb :home
end
end

