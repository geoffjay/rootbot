# Root 🤖

Slack bot to demonstrate slash commands using Ruby-on-Rails.

## Develop

Create the file `config/local_env.yml`.

```shell
cat <<EOF>config/local_env.yml
REDIS_URL: "redis://localhost:6379"
SLACK_ROOTBOT_TOKEN: "token from app that was created"
EOF
```

Create the file `.env`.

```shell
cat <<EOF>.env
OVERMIND_NO_PORT=1
RACK_ENV=development
PORT=3000
EOF
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

### Perform Database Migrations

```shell
heroku run rake db:migrate
```
