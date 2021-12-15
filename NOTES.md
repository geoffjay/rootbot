# Rootly Slack Bot Notes

## What would I Improve?

- user, organization, and team models to support more than one instance
- `creator` would have a model and incidents would have a relationship
- incident statuses could come from a table
- the severity list could be a list that the user could create
- the `enum` types for an incident status and severity could be a class, [eg][enum]
- using `skip_before_action` in the incidents controller shouldn't be done in production
- restrict `/slack` endpoint to appropriate source
- handle CSRF correctly
- didn't test all HTTP request responses
- better error handling
- make a generic HTTP client so that I don't need to keep reading the API token
- there's a lot of digs on the payload, using `to_h` wasn't working as expected
- set the channel topic to something on create, and to "resolved on" on `resolve`

## Tests

- need to run `bin/rake db:test:prepare` against `heroku`
- tests run with `rspec spec/`

<!-- references -->

[enum]: https://naturaily.com/blog/ruby-on-rails-enum
