require 'rails_helper'

RSpec.describe "shortened_urls/index", type: :view do
  before(:each) do
    assign(:shortened_urls, [
      ShortenedUrl.create!(),
      ShortenedUrl.create!()
    ])
  end

  it "renders a list of shortened_urls" do
    render
  end
end
