# Custom library to implement google oauth2
require 'net/http'

class GoogleOauth2
  OAUTH_URL = 'https://accounts.google.com/o/oauth2/auth'.freeze
  TOKEN_URL = 'https://accounts.google.com/o/oauth2/token'.freeze

  attr_reader :client_id
  attr_reader :client_secret
  attr_reader :redirect_uri
  attr_reader :scope_url
  attr_reader :access_token
  attr_reader :refresh_token
  attr_reader :expires_in

  def initialize(client_id, client_secret, redirect_uri, scope_url)
    @client_id     = client_id
    @client_secret = client_secret
    @redirect_uri  = redirect_uri
    @scope_url     = scope_url
  end

  # Redirect users to this url request for authorization
  def authorization_url
    uri = URI(OAUTH_URL)
    uri.query = {
      client_id: client_id,
      redirect_uri: redirect_uri,
      scope: scope_url,
      response_type: 'code',
      access_type: 'offline'
    }.to_param

    uri.to_s
  end

  # After user authorized the app, request for a token to allow retrieving history
  def request_token(code)
    params = {
      code: code,
      client_id: client_id,
      client_secret: client_secret,
      redirect_uri: redirect_uri,
      grant_type: 'authorization_code'
    }.to_param

    header   = { 'Content-Type' => 'application/x-www-form-urlencoded' }
    uri      = URI(TOKEN_URL)
    net_http = Net::HTTP.new(uri.host, uri.port)
    net_http.use_ssl = true
    request  = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = params
    response = net_http.request(request)
    if response.code == '200'
      data = JSON.load(response.body)
      @access_token  = data['access_token']
      @refresh_token = data['refresh_token']
      @expires_in    = data['expires_in']
    else
      raise StandardError.new(response.body)
    end
  end
end
