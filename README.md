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
  default_topic: [TOPIC]
  default_subscription: [SUB]
  pubsub_credentials_path: [CREDENTIALS_PATH]
```
Start the background job queue:
```
$ rake verbose pub_sub:listen_to_subscriptions
```
Remove `verbose` if you don't want log messages to show on STDOUT.

Now you can enqueue jobs like so:
```
TestJob.perform_later('Hello, World!', 'TestJob', ['firstTopic', 'secondTopic'])
```
Where the first argument is the message to send to the job, the second argument is the name of the job Class, and the third (optional) argument is an array of topics to send the message to.

To create a new job add it to the whitelist on `lib/tasks/pub_sub.rake`. 

It's also possible to register multiple subscribers by creating a `Subscriber` object like so:
```
subscriber = Subscriber.new(['testTopic.testSubscription', 'secondTopic.secondSubscription'])
```
Each string must be in the `topic.subscription` format.

Running example:

![image](https://user-images.githubusercontent.com/2192093/44931978-f762f980-ad39-11e8-977c-ea132a498bc0.png)

![image](https://user-images.githubusercontent.com/2192093/44932009-15305e80-ad3a-11e8-9296-45b761d67aaf.png)

