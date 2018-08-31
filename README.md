# Backend Coding Challenge

Install by cloning this repository and running `bundle install`.

```
$ git clone git@github.com:adrianob/kisi_test.git
$ cd kisi_test
$ bundle install
```

Create the `config/settings.yml` file and configure it using you Google Pub/Sub settings(you'll also need to copy your credentials file somewhere inside the repo):
```
$ cp config/settings.example.yml config/settings.yml
```
```
  # Edit the values below
  project_id: [PROJECT_ID]
  pubsub_topic: [TOPIC]
  pubsub_subscription: [SUB]
  pubsub_credentials_path: [CREDENTIALS_PATH]
```
Start the background job queue:
```
$ rake verbose pub_sub:listen_to_subscriptions
```
Remove `verbose` if you don't want log messages to show on STDOUT.

Now you can enqueue jobs like so:
```
TestJob.perform_later({job: 'TestJob', arg1: 1, arg2: :foo})
```

You need to pass a hash with a `job` key for the listener worker to recognize your job. To create a new job add it to the whitelist on `lib/tasks/pub_sub.rake`.
