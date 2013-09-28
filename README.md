# Kanpachi

[![CI Build Status](https://secure.travis-ci.org/kamui/kanpachi.png?branch=master)](http://travis-ci.org/kamui/kanpachi)

Kanpachi is a ruby gem that provides a DSL to describe your web API, generate documentation, and will even eventually
help you implement it.

Resource input parameters are defiend with the [mutations](https://github.com/cypriss/mutations) gem. You can refer to
their [wiki](https://github.com/cypriss/mutations/wiki/Filtering-Input) to find out how to use their DSL.

Response representations are defined as [Roar](https://github.com/apotonick/roar) representers. You can check out the
[representable docs](https://github.com/apotonick/representable) to figure out how to customize your responses.

To check out an example API project, checkout [kanpachi-example](https://github.com/kamui/kanpachi-example).

This project was inspired by [@mattetti](https://github.com/mattetti/)'s [Weasel-Diesel](https://github.com/mattetti/Weasel-Diesel) project, of which I am also a contributor. I created Kanpachi as a way of experimenting and leaning how to create a DSL in ruby.

## Example

Below is an example of one of Twitter's API endpoints partially described in Kanpachi.

```ruby
api 'Twitter' do
  # API meta data
  title 'REST API v1.1 Resources'
  description 'This describes the resources that make up the official Twitter API v1.1'
  host 'api.twitter.com'

  # Define global error responses
  error :malformed_params do
    description 'Sending invalid JSON will result in a 400 Bad Request response.'

    response do
      status 400
      header 'Content-Type', 'application/json'
      representation do
        property :message, type: String
      end
    end
  end

  section 'Timelines' do
    description 'Timelines are collections of Tweets, ordered with the most recent first.'

    resource :get, '/statuses/mentions_timeline' do
      name 'Mentions timeline'
      description <<-TEXT
Returns the 20 most recent mentions (tweets containing a users's @screen_name) for the authenticating user.

The timeline returned is the equivalent of the one seen when you view [your mentions](https://twitter.com/mentions) on twitter.com.

This method can only return up to 800 tweets.

See [__Working with Timelines__](https://dev.twitter.com/docs/working-with-timelines) for instructions on traversing timelines.
TEXT
      versions '1.1', 1.0
      ssl true
      formats :json

      # Params are a subclass of Mutations::Command
      params do
        required do
        end

        optional do
          integer :count, doc: 'Specifies the number of tweets to try and retrieve, up to a maximum of 200. The value of count is best thought of as a limit to the number of tweets to return because suspended or deleted content is removed after the count has been applied. We include retweets in the count, even if `include_rts` is not supplied. It is recommended you always send `include_rts=1` when using this API method.'
          integer :since_id, doc: 'Returns results with an ID greater than (that is, more recent than) the specified ID. There are limits to the number of Tweets which can be accessed through the API. If the limit of Tweets has occured since the since_id, the since_id will be forced to the oldest ID available.', example: 12345
          integer :max_id, doc: 'Returns results with an ID less than (that is, older than) or equal to the specified ID.', example: 54321
          boolean :trim_user, doc: 'When set to either true, t or 1, each tweet returned in a timeline will include a user object including only the status authors numerical ID. Omit this parameter to receive the complete user object.', example: true
          boolean :contributor_details, doc: 'This parameter enhances the contributors element of the status response to include the screen_name of the contributor. By default only the user_id of the contributor is included.', example: true
          boolean :include_entities, doc: 'The `entities` node will be disincluded when set to false.', example: false
        end
      end

      # Multiple responses are supported
      response :default do
        status 200
        header 'Content-Type', 'application/json'

        # Response representations include Roar::Representer
        representation do
          include ::Representable::JSON::Collection
          property :title, type: String, doc: "it's the title", example: 'The Title'
          collection :coordinates, doc: "it's the coordinates", example: [100.4, 45.1]
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

Create a new API

```bash
$ kanpachi new my_api
$ cd my_api
```

Build HTML documentation

```bash
$ kanpachi build
```

Start a documentation server

```bash
$ kanpachi server
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
