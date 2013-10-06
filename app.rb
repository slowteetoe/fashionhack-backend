require 'sinatra'
require 'json'

configure do
  set :protection, :except => [:http_origin]
  require 'redis'
  redisUri = ENV["REDISTOGO_URL"] || 'redis://localhost:6379'
  uri = URI.parse(redisUri) 
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

get '/getData' do
  { "http://fashionhack.com:4567/tumblr_mu5nuwmOMB1sk4zhuo1_500.jpg_707_500" => "http://www.betabrand.com/mens/pants/mens-japants-cargo-pants.html"}.to_json
end

post '/getData' do
  data = request.body.read
  logger.info "getting data, available: #{data}"
  result = {}
  manifest = JSON.parse data
  logger.info "manifest is: #{manifest}"
  manifest.each do |k|
  	val = REDIS.get k
  	next if val.nil?
  	result[k] = val
  end
  logger.info result
  result.to_json
end

post '/dataFor' do
	url = params.fetch("product_url")
	key = params.fetch("image_hash")
	REDIS.set(key, url)
	"ok"
end
