require 'rspec'
require "net/https"
require "uri"
require 'openssl'
require 'json'
require 'yaml'

describe 'API' do

  it 'should connect to flikr with api key' do
    uri = URI.parse("https://api.flickr.com/services/rest/?&method=flickr.people.getPublicPhotos&api_key=#{get_key}&user_id=141841797@N06&format=json")
    expect(test_api(uri).response.kind_of? Net::HTTPSuccess)
  end

  it 'should get info on a photo' do
    uri = URI.parse("https://api.flickr.com/services/rest/?&method=flickr.photos.getInfo&api_key=#{get_key}&photo_id=26262870621&format=json&nojsoncallback=1")
    response = test_api(uri)
    photo_info = JSON.parse(response.body)
    expect(response.kind_of? Net::HTTPSuccess)
    expect(photo_info['photo']['id']).to eq('26262870621')
  end

  it 'should pull key from yaml file' do
    uri = URI.parse("https://api.flickr.com/services/rest/?&method=flickr.photos.getInfo&api_key=#{get_key}&photo_id=26262870621&format=json&nojsoncallback=1")
    response = test_api(uri)
    JSON.parse(response.body)
    expect(response.kind_of? Net::HTTPSuccess)
  end

end

private

def get_key
  YAML.load_file('api_key.yml')['key']
end

def test_api(uri)
# Shortcut
  response = Net::HTTP.get_response(uri)

# Will print response.body
  Net::HTTP.get_print(uri)

# Full
  http = Net::HTTP.new(uri.host, 443)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  response = http.request(Net::HTTP::Get.new(uri.request_uri))
end