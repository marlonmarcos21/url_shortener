require 'rails_helper'

RSpec.describe "shortened_urls/show", type: :view do
  before(:each) do
    @shortened_url = assign(:shortened_url, ShortenedUrl.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
