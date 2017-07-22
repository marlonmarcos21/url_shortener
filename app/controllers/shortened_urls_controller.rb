class ShortenedUrlsController < ApplicationController
  def index
  end

  def shorten_url
    @data = google_url_shortener.shorten_url(params[:url])
    respond_to :js
  end

  def expand_url
    @data = google_url_shortener.expand_url(params[:url])
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
