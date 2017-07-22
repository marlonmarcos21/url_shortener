# I would have used googl gem (https://github.com/zigotto/googl)
# But I wanted to make it more fun & challenging so I implemented my own :)
class GoogleUrlShortener
  API_URL = 'https://www.googleapis.com/urlshortener/v1/url'.freeze

  attr_reader :api_key
  attr_reader :uri
  attr_reader :net_http

  def initialize(api_key)
    @api_key  = api_key
    @uri      = request_uri
    @net_http = Net::HTTP.new(uri.host, uri.port)
    @net_http.use_ssl = true
  end

  def shorten_url(long_url)
    header       = { 'Content-Type' => 'application/json' }
    request      = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = { longUrl: long_url }.to_json
    response     = net_http.request(request)
    get_api_response(response)
  end

  def expand_url(short_url)
    response = expand_url_request(short_url)
    get_api_response(response)
  end

  # This is almost the same as expand_url
  # but with analytics data added in the response
  def shortened_url_analytics(short_url)
    response = expand_url_request(short_url, true)
    get_api_response(response)
  end

  private

  def request_uri
    uri = URI(API_URL)
    uri.query = { key: api_key }.to_param
    uri
  end

  def get_api_response(response)
    return JSON.load(response.body) if response.code == '200'
    raise StandardError.new(response.body)
  end

  def expand_url_request(short_url, analytics = false)
    expand_uri        = uri.dup
    expand_uri.query  = "#{expand_uri.query}&shortUrl=#{short_url}"
    expand_uri.query += '&projection=FULL' if analytics

    request = Net::HTTP::Get.new(expand_uri.request_uri)
    net_http.request(request)
  end
end
