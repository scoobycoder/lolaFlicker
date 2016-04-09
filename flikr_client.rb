class FlikrClient

  attr_accessor :key, :id

  def initialize
    get_key
    get_user_id
  end

  def test_api(uri)
    http = Net::HTTP.new(uri.host, 443)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.request(Net::HTTP::Get.new(uri.request_uri))
  end

  private

  def get_key
    @key = YAML.load_file('api_key.yml')['key']
  end

  def get_user_id
    @id = YAML.load_file('api_key.yml')['user_id']
  end

end