require 'rails_helper'

RSpec.describe "shortened_urls/edit", type: :view do
  before(:each) do
    @shortened_url = assign(:shortened_url, ShortenedUrl.create!())
  end

  it "renders the edit shortened_url form" do
    render

    assert_select "form[action=?][method=?]", shortened_url_path(@shortened_url), "post" do
    end
  end
end
