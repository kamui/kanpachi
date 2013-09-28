# Kanpachi

[![CI Build Status](https://secure.travis-ci.org/kamui/kanpachi.png?branch=master)](http://travis-ci.org/kamui/kanpachi)

TODO: Write a gem description

```ruby
api 'Twitter' do
  title 'API v1.1'
  description 'This describes the resources that make up the official Twitter API v1.1'
  host 'api.twitter.com'

  error :malformed_params do
    status 400

    description 'Sending invalid JSON will result in a 400 Bad Request response.'
    example 'Some example of malformed input.'

    response do
      property :message, type: String
    end
  end

  section 'Tweets' do
    description 'Tweets are the atomic building blocks of Twitter, 140-character status updates with additional associated metadata. People tweet for a variety of reasons about a multitude of topics.'

    resource :get, 'statuses/show/:id' do
      name 'Return a single tweet'
      description <<-TEXT
        Returns a single Tweet, specified by the id parameter. The Tweet's author will also be embedded within the tweet. See Embeddable Timelines, Embeddable Tweets, and GET statuses/oembed for tools to render Tweets according to Display Requirements.
      TEXT
      versions '1.1'
      ssl true
      authentication true
      formats :json

      params do
        required do
          integer :id, description: 'The numerical ID of the desired Tweet.'
        end

        optional do
          string :trim_user, in: ['true', 't', '1'], description: 'When set to either true, t or 1, each tweet returned in a timeline will include a user object including only the status authors numerical ID. Omit this parameter to receive the complete user object.'
          string :include_my_retweet, in: ['true', 't', '1']
          string :include_entities, in: ['true', 't', '1']
        end
      end

      response do
        status 200
        header 'Content-Type', 'application/json'
        representation do
          property :id_str, type: String, description: 'Stringified version of the id'
          property :favorited, type: Boolean, description: 'Is this tweet favorited?'
          collection :users, extend: UserRepresenter, description: 'Users collection'
        end
      end
    end
  end
end
```

## Installation

Add this line to your application's Gemfile:

    gem 'kanpachi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kanpachi

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
