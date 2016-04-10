require './flikr_client'
require 'rspec'
require "net/https"
require "uri"
require 'openssl'
require 'json'
require 'yaml'

describe 'API' do

  before do
    @client = FlikrClient.new
  end

  it 'should connect to flikr with api key' do
    uri = URI.parse("https://api.flickr.com/services/rest/?&method=flickr.people.getPublicPhotos&api_key=#{@client.key}&user_id=#{@client.id}&format=json")
    expect(@client.test_api(uri).response.kind_of? Net::HTTPSuccess)
  end

  it 'should get info on a photo' do
    uri = URI.parse("https://api.flickr.com/services/rest/?&method=flickr.photos.getInfo&api_key=#{@client.key}&photo_id=26262870621&format=json&nojsoncallback=1")
    response = @client.test_api(uri)
    photo_info = JSON.parse(response.body)
    expect(response.kind_of? Net::HTTPSuccess)
    expect(photo_info['photo']['id']).to eq('26262870621')
  end

  it 'should show image' do
    uri = URI.parse("https://api.flickr.com/services/rest/?&method=flickr.photos.getInfo&api_key=#{@client.key}&photo_id=26262870621&format=json&nojsoncallback=1&extras=url_o")
    response = @client.test_api(uri)
    photo_info = JSON.parse(response.body)
    image_url = photo_info['photo']['urls']['url']#['_content']
    p "============="
    p image_url
    p "============="
    expect(response.kind_of? Net::HTTPSuccess)
  end

end
