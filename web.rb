require 'sinatra'
require 'oauth'
require 'json'

get '/' do
  "Hello, world"
end

get '/auth' do

  # Fill the keys and secrets you retrieved after registering your app
  api_key = ENV['cm_api_key']
  api_secret = ENV['cm_api_secret']
  user_token = ENV['cm_user_token']
  user_secret = ENV['cm_user_secret']

  # Specify LinkedIn API endpoint
  configuration = { :site => 'https://api.linkedin.com' }

  # Use your API key and secret to instantiate consumer object
  consumer = OAuth::Consumer.new(api_key, api_secret, configuration)

  # Use your developer token and secret to instantiate access token object
  access_token = OAuth::AccessToken.new(consumer, user_token, user_secret)

  # By default, the LinkedIn API responses are in XML format. If you prefer JSON, simply specify the format in your call
  response = access_token.get("http://api.linkedin.com/v1/people/~?format=json")

  content_type :json
  response.body
end