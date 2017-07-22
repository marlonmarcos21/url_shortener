require 'rails_helper'

RSpec.describe "shortened_urls/new", type: :view do
  before(:each) do
    assign(:shortened_url, ShortenedUrl.new())
  end

  it "renders new shortened_url form" do
    render

    assert_select "form[action=?][method=?]", shortened_urls_path, "post" do
    end
  end
end
