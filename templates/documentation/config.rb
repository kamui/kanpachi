# Middleman extended configuration
# For options, refer to http://middlemanapp.com/advanced/configuration

# Reload the browser automatically whenever files change
activate :livereload

configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, '/docs/'
end