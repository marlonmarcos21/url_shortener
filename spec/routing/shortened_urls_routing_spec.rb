require "rails_helper"

RSpec.describe ShortenedUrlsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/shortened_urls").to route_to("shortened_urls#index")
    end

    it "routes to #shorten_url" do
      expect(:get => "/shortened_urls/shorten_url").to route_to("shortened_urls#shorten_url")
    end

    it "routes to #expand_url" do
      expect(:get => "/shortened_urls/expand_url").to route_to("shortened_urls#expand_url")
    end

    it "routes to #public_analytics" do
      expect(:get => "/shortened_urls/public_analytics").to route_to("shortened_urls#public_analytics")
    end
  end
end
