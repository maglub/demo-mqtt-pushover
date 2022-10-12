# Introduction

This repo is show how to listen to an MQTT topic and send a notification when a certain value is posted. This example shows how to use Pushover and Slack, but is easily extended to use other push notifications. I created this demo after a discussion with a guy in an Arduino forum, where the topic was similar to "we don't have a home automatino system, but are receiving MQTT messages that we would like to route to a push notification".

This is a very small, working prototype to show how to filter on MQTT topic/values to decide on when to send a notification message, and a couple of ways to send the actual message.

I would normally not implement it this way, but in the absence of a home automation system you will need some sort of engine that consumes the MQTT messages and makes the decision on when to send a notification.

Different messaging services, that are equally easy to implement:

* Slack
* Teams
* Mattermost
* Pushover

MQTT is a lightweight protocol used in home automation and IOT (internet of things) devices. It requires an MQTT broker, for example the Mosquitto Broker. It is often integrated in home automation systems (like Homeassistant).

What you need:

* A pushover account (at https://pushover.net) or a slack account (https://slack.com)
* A pushover user token (you will get that as soon as you create your account), and a pushover application token (has to be created in the cockpit under "Your Applications")
* Or, a slack webhook URL

# Pre reqs

You need mosquitto-clients installed. On Ubuntu:

```
sudo apt-get install mosquitto-clients
```

# How to use (Pushover)

* Configure your Pushover account (create one, create an application token)
* Configure your ./etc/app.conf (add your mqtt broker ip, user/password, then the pushover user token and the pushover application token)

```
cp etc/app.conf.template etc/app.conf
vi etc/app.conf
```

* Push to messaging service

```
./bin/send_message.SERVICE "my message"
```

* Run the consumer:

```
./bin/consume.sh
```

* Start the consumer in the background:

```
nohup ./bin/consume.sh > /dev/null 2>&1 &
```

* Crontab entry to start at boot:

```
@reboot cd /path/to/where/you/cloned/this ; nohup ./bin/consume.sh > /dev/null 2>&1
```

# Test with MQTT Explorer

* Log into your broker
* Publish a raw value of "1" into the topic "my/topic/path/x"

![mqtt-explorer-publish.png](/illustrations/mqtt-explorer-publish.png?raw=true "Publish topic")

# References

* https://mosquitto.org/
* https://pushover.net/
* https://slack.com
* https://pushover.net/api
* https://funprojects.blog/2021/05/25/bash-with-mqtt/
* http://www.steves-internet-guide.com/mosquitto_pub-sub-clients/
* http://mqtt-explorer.com/
