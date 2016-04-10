class FlikrClient

  attr_accessor :key, :id

  def initialize
    get_keys
  end

  def test_api(uri)
    http = Net::HTTP.new(uri.host, 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.request(Net::HTTP::Get.new(uri.request_uri))
  end

  private

  def get_keys
    keys = YAML.load_file('api_key.yml')
    @key = keys['key']
    @id = keys['user_id']
  end

end