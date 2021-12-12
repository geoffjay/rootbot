# Rootly Slack Bot Notes

## What would I Improve?

- `creator` would have a model and incidents would have a relationship
- incident statuses could come from a table
- the severity list could be a list that the user could create
- the `enum` types for an incident status and severity could be a class, [eg][enum]
- using `skip_before_action` in the incidents controller shouldn't be done in production
- restrict `/slack` endpoint to appropriate source
- handle CSRF correctly

## Tests

- need to run `bin/rake db:test:prepare` against `heroku`
- tests run with `rspec spec/`

<!-- references -->

[enum]: https://naturaily.com/blog/ruby-on-rails-enum
