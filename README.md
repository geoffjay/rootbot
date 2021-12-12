# Rootly 🤖

Slack bot to demonstrate slash commands using Ruby-on-Rails.

## Develop

Create the file `config/local_env.yml` with the content:

```yaml
REDIS_URL: "redis://localhost:6379"
SLACK_ROOTBOT_TOKEN: "token from app that was created"
```

Launch everything

- start required services

  ```shell
  docker compose up -d
  ```

- start `rails` and `sidekiq`

  ```shell
  overmind start
  ```

- start the `webpack` development service

  ```shell
  bin/webpack-dev-server
  ```

## Deploy

```shell
git push heroku main
heroku ps:scale web=1
heroku ps:scale worker+1
```
