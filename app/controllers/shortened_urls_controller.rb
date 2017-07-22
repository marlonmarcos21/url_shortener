class ShortenedUrlsController < ApplicationController
  def index
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

  private

  def google_url_shortener
    @google_url_shortener ||= GoogleUrlShortener.new(ENV['GOOGLE_API_KEY'])
  end
end
