require 'rails_helper'

RSpec.describe ShortenedUrl, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:short_url) }
    it { is_expected.to validate_presence_of(:long_url) }
    it { is_expected.to validate_uniqueness_of(:short_url) }
    it { is_expected.to validate_uniqueness_of(:long_url) }
  end
end
