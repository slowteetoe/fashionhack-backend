require 'sinatra'
require 'json'

configure do
  require 'redis'
  redisUri = ENV["REDISTOGO_URL"] || 'redis://localhost:6379'
  uri = URI.parse(redisUri) 
  REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

get '/getData' do
  { "http://fashionhack.com:4567/tumblr_mu5nuwmOMB1sk4zhuo1_500.jpg_707_500" => "http://www.betabrand.com/mens/pants/mens-japants-cargo-pants.html"}.to_json
end

post '/getData' do
  logger.info "getting data for #{params[:manifest]}"
  { "http://fashionhack.com:4567/tumblr_mu5nuwmOMB1sk4zhuo1_500.jpg_707_500" => "http://www.betabrand.com/mens/pants/mens-japants-cargo-pants.html"}.to_json
end
