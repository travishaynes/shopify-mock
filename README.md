ShopifyAPI::Mock
================

This gem is used for testing apps that use
[shopify_api](https://github.com/Shopify/shopify_api) without having to actually
connect to Shopify to develop the application.

## Installation

Add the gem to your Gemfile in the appropriate group:

    gem 'shopify-mock', group: test

## Usage

### Quickstart

Use `ShopifyAPI::Mock.setup` in either the test helper or on a test by test
basis. The Shopify API requires an access token. A randomly generated token is
provided by default, but it can be set manually when necessary:

```ruby
ShopifyAPI::Mock.token = 'a4ba06e4f49cf349d973d461f52a3a21'
```

Once the token is set it will be used until `ShopifyAPI::Mock.teardown` is
called, which will reset the fixtures and the token to nil. The next time the
token is requested a new one will be randomly generated.

### ActiveResource::HttpMock

To use additional ActiveResource mocked responses alongside this gem's, supply
an `ActiveResource::HttpMock::Responder` instance to `ShopifyAPI::Mock.setup`:

```ruby
ActiveResource::HttpMock.respond_to do |mock|
  ShopifyAPI::Mock.setup(mock)

  # define additional mocks here
end
```

Use `ShopifyAPI::Mock.teardown` instead of `ActiveResource::HttpMock.reset`.

### Fixtures

The mocked requests and responses are located in this gem's `fixtures` folder.
The folder's structure looks like this:

    fixtures
    ├── requests
    |   ├── delete
    |   ├── get
    |   ├── post
    │   ├── post
    │   └── put
    └── responses
        ├── delete
        ├── get
        ├── post
        └── put

The requests will only be used if they have a corresponding response. To provide
a custom HTTP status code or headers include a YAML header in the fixture. For
example:

    ---
    status: 404
    headers:
      "Content-Type": "text/plain"
    ---

The `---` dashes before and after the header are required.

ERB can be used inside the fixtures for dynamic requests and responses.

To add additional requests and responses create a directory that has the same
structure and add it to `ShopifyAPI::Mock.fixture_paths`. For example:

```ruby
ShopifyAPI::Mock.fixture_paths << Rails.root.join('lib/fixtures/shopify_api')
```

It is also possible to remove the default paths and only use custom fixtures:

```ruby
ShopifyAPI::Mock.fixture_paths.clear
ShopifyAPI::Mock.fixture_paths << Rails.root.join('lib/fixtures/shopify_api')
```

The fixture paths will be loaded in the order they appear in the array. Any
duplicate entries will be overridden by the last one that is loaded. So the
requests and responses in custom fixture paths will take precedence over the
default ones.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release` to create a git tag for the version, push git commits
and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. [Fork it](https://github.com/travishaynes/shopify-mock/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
