class ShortenedUrlsController < ApplicationController
  def index
    @google_auth_url = google_oauth2.authorization_url
  end

  def shorten_url
    shortened_url = ShortenedUrl.find_by(long_url: params[:url])
    if shortened_url
      @data = ShortenedUrl.convert_to_google_format(shortened_url)
    else
      @data = google_url_shortener.shorten_url(params[:url])
      ShortenedUrl.create_from_google_data(@data)
    end
    respond_to :js
  end

  def expand_url
    shortened_url = ShortenedUrl.find_by(short_url: params[:url])
    if shortened_url
      @data = ShortenedUrl.convert_to_google_format(shortened_url)
    else
      @data = google_url_shortener.expand_url(params[:url])
      ShortenedUrl.create_from_google_data(@data)
    end
    respond_to :js
  end

  def public_analytics
    @data = google_url_shortener.shortened_url_analytics(params[:url])
    respond_to :js
  end

  # Using cookies here might not the best option
  # I would rather store this in the db
  # But since the app does not have user authentication,
  # cookies was used for the sake of testing
  # TODO: handle pagination, user history is paginated
  def user_history
    return redirect_to google_oauth2.authorization_url unless cookies[:google_access_token]
    @data = google_url_shortener.user_history(cookies[:google_access_token])
  end

  # redirect uri's callback method after authorizing
  def oauth2
    google_oauth2.request_token(params['code'])
    cookies[:google_access_token] = {
      value: google_oauth2.access_token,
      expires: Time.zone.now + google_oauth2.expires_in
    }
    redirect_to user_history_shortened_urls_path
  end

  private

  def google_url_shortener
    @google_url_shortener ||= GoogleUrlShortener.new(ENV['GOOGLE_API_KEY'])
  end

  def google_oauth2
    @google_oauth2 ||= GoogleOauth2.new(
      ENV['GOOGLE_CLIENT_ID'],
      ENV['GOOGLE_CLIENT_SECRET'],
      ENV['GOOGLE_REDIRECT_URI'],
      GoogleUrlShortener::SCOPE_URL
    )
  end
end
