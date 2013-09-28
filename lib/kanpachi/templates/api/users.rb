api 'MyAPI' do
  section 'Users' do
    resource :post, '/users' do
      name 'Create a user'
      description <<-TEXT
__Creates a user__. `User`'s must provide a valid email address. Upon registration,
an activation email will be sent to the user.
TEXT
      versions '1.0'
      ssl true
      formats :json

      params do
        required do
          string :email, doc: 'Email address', example: 'user@example.com'
          string :full_name, doc: 'Full name', example: 'Jack Chu'
          string :password, min_length: 8, doc: 'The password must be 8 characters minumum', example: 'notPassword'
          string :password_confirmation, min_length: 8, doc: 'Password (confirm)'
          integer :age, doc: 'Age', example: 21
        end

        optional do
          boolean :newsletter, doc: 'Do you want our weekly newsletter?'
        end
      end

      response do
        status 201
        header 'Content-Type', 'application/json'
        representation do
          property :message, type: String, doc: 'Thank you message for the user.', example: 'Thanks for registering!'
          collection :roles, doc: 'The authorization roles this user has.', example: ['member', 'superuser']
          hash :preferences, doc: 'The preferences for this user.', example: {remember_me: true, newsletter: false}
        end
      end
    end
  end
end
