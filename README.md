# Teamtailor

[![Gem Version](https://badge.fury.io/rb/teamtailor.svg)](https://badge.fury.io/rb/teamtailor)

The `teamtailor` gem helps Ruby developers interact with their Teamtailor
account, using classes that wrap the [Teamtailor API][teamtailor-api].

[teamtailor-api]: https://docs.teamtailor.com/


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'teamtailor'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install teamtailor


## Usage

To use the library, you need an API key for a specific Teamtailor account, which
you can create by signing in as an Admin in Teamtailor and generating a new
key under _Settings_.

```ruby
@client = Teamtailor::Client.new(
  base_url: 'https://api.teamtailor.com',
  api_token: '<PRIVATE API KEY>',
  api_version: 20161108
)
```

### Pagination

The gem does not automatically paginate through all the pages of an API
endpoint is something you can do. The `#has_next_page?` method is
helpful when knowing if there's more to fetch.

To fetch all jobs, you could do something like this:

```ruby
current_page = 1
jobs = []

while (page_result = @client.jobs(page: current_page))
  jobs.append *page_result.records
  break unless page_result.has_next_page?
  current_page += 1
end
```

You can get all the titles through the `#title` method.

```ruby
irb(main):041:0> jobs.map &:title
=> ["EmberJS Developer", "Ruby on Rails developer"]
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/bzf/teamtailor-rb.


## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).
