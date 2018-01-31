# README

### Clone:

```
git clone https://github.com/marlonmarcos21/url_shortener.git
```

### Setup:

* Execute bundle install:

```
bundle install
```

* Setup Database (App is using postgres, change to your preferred database if needed)

```
bundle exec rake db:setup
```

* Create `.env` file

```
cp .env.example .env
```

* Create google API key and OAuth Client ID [here](https://console.developers.google.com/apis/credentials)

* Sample APP can be found [here](https://url-shortener.gravity.ph)

### Run tests:

```
bundle exec rspec
```
