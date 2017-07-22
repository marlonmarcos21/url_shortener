class ShortenedUrl < ApplicationRecord
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true, uniqueness: true

  class << self
    def create_from_google_data(data)
      create(short_url: data['id'], long_url: data['longUrl'])
    end

    def convert_to_google_format(shortened_url)
      {
        'id' => shortened_url.short_url,
        'longUrl' => shortened_url.long_url
      }
    end
  end
end
