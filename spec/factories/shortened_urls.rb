FactoryGirl.define do
  factory :shortened_url do
    short_url 'https://goo.gl/uRup1a'
    long_url  'https://www.google.com.sg'
  end
end
