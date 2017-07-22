require 'rails_helper'

describe GoogleUrlShortener do
  before do
    @shortener = GoogleUrlShortener.new(ENV['GOOGLE_API_KEY'])
  end

  describe '#shorten_url' do
    subject do
      VCR.use_cassette 'google/url_shortener', record: :new_episodes do
        @shortener.shorten_url('https://www.google.com.sg')
      end
    end

    it 'returns a hash with the shortened url in it' do
      data = { 'kind' => 'urlshortener#url', 'id' => 'https://goo.gl/ssxgl', 'longUrl' => 'https://www.google.com.sg/' }
      is_expected.to eq(data)
    end
  end

  describe '#expand_url' do
    subject do
      VCR.use_cassette 'google/url_shortener', record: :new_episodes do
        @shortener.expand_url(@shortened_url)
      end
    end

    describe 'expanding a valid shortened url' do
      before { @shortened_url = 'https://goo.gl/ssxgl' }

      it 'returns a hash with the long url in it' do
        data = { 'kind' => 'urlshortener#url', 'id' => 'https://goo.gl/ssxgl', 'longUrl' => 'https://www.google.com.sg/', 'status' => 'OK'}
        is_expected.to eq(data)
      end
    end

    describe 'expanding an invalid shortened url' do
      before { @shortened_url = 'https://invalid-url.com' }

      it 'should raise an error' do
        expect { subject }.to raise_error(StandardError)
      end
    end
  end

  describe '#shortened_url_analytics' do
    subject do
      VCR.use_cassette 'google/url_shortener', record: :new_episodes do
        @shortener.shortened_url_analytics(@shortened_url)
      end
    end

    describe 'getting analytics for a valid shortened url' do
      before { @shortened_url = 'https://goo.gl/ssxgl' }

      it 'returns a hash with analytics key in it' do
        data = subject
        expect(data['analytics']).not_to be_nil
      end
    end

    describe 'getting analytics for an invalid shortened url' do
      before { @shortened_url = 'https://invalid-url.com' }

      it 'should raise an error' do
        expect { subject }.to raise_error(StandardError)
      end
    end
  end
end
