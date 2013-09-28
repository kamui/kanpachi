require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module UserRepresenter
  include Roar::Representer::JSON
  include Roar::Representer::Feature::Hypermedia
  property :first_name, type: String, required: true, doc: "it's the first name"
  property :last_name, type: String, required: true, doc: "it's the last name"
end

api 'Twitter' do
  title 'REST API v1.1 Resources'
  description 'This describes the resources that make up the official Twitter API v1.1'
  host 'api.twitter.com'

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

The timeline returned is the equivalent of the one seen when you view your mentions on twitter.com.

This method can only return up to 800 tweets.

See __Working with Timelines__ for instructions on traversing timelines.
TEXT
      versions '1.1'
      ssl true
      formats :json

      params do
        optional do
          integer :count, doc: 'Specifies the number of tweets to try and retrieve, up to a maximum of 200. The value of count is best thought of as a limit to the number of tweets to return because suspended or deleted content is removed after the count has been applied. We include retweets in the count, even if `include_rts` is not supplied. It is recommended you always send `include_rts=1` when using this API method.'
          integer :since_id, doc: 'Returns results with an ID greater than (that is, more recent than) the specified ID. There are limits to the number of Tweets which can be accessed through the API. If the limit of Tweets has occured since the since_id, the since_id will be forced to the oldest ID available.

__Example Values__: 12345'
          integer :max_id, doc: 'Returns results with an ID less than (that is, older than) or equal to the specified ID.

__Example Values__: 54321'
          boolean :trim_user, doc: 'When set to either true, t or 1, each tweet returned in a timeline will include a user object including only the status authors numerical ID. Omit this parameter to receive the complete user object.

__Example Values__: true'
          boolean :contributor_details, doc: 'This parameter enhances the contributors element of the status response to include the screen_name of the contributor. By default only the user_id of the contributor is included.

__Example Values__: true'
          boolean :include_entities, doc: 'The `entities` node will be disincluded when set to false.

__Example Values__: false'
        end
      end

      response do
        status 200
        header 'Content-Type', 'application/json'
        representation do
          property :id, type: Integer, doc: "it's the id"
          property :title, type: String, doc: "it's the title"
          collection :users, extend: UserRepresenter, doc: "it's the users"
        end
      end
    end

    resource :get, '/statuses/user_timeline' do
      name 'User timeline'
      description <<-TEXT
Returns a collection of the most recent Tweets posted by the user indicated by the screen_name or user_id parameters.

User timelines belonging to protected users may only be requested when the authenticated user either "owns" the timeline or is an approved follower of the owner.

The timeline returned is the equivalent of the one seen when you view a user's profile on twitter.com.

This method can only return up to 3,200 of a user's most recent Tweets. Native retweets of other statuses by the user is included in this total, regardless of whether include_rts is set to false when requesting this resource.

See Working with Timelines for instructions on traversing timelines.

See Embeddable Timelines, Embeddable Tweets, and GET statuses/oembed for tools to render Tweets according to Display Requirements.
TEXT
      versions '1.1'
      ssl true
      formats :json

      params do
        optional do
          integer :user_id
          string :screen_name
          integer :since_id
          integer :count
          integer :max_id
          boolean :trim_user
          boolean :exclude_replies
          boolean :contributor_details
          boolean :include_rts
        end
      end

      response do
        status 200
        header 'Content-Type', 'application/json'
        representation do
          property :id, type: Integer, doc: "it's the id"
          property :title, type: String, doc: "it's the title"
          collection :users, extend: UserRepresenter, doc: "it's the users"
        end
      end
    end
  end
end
