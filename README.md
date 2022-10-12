# Introduction

How to listen to an MQTT topic and send a notification when a certain value is posted. This example shows how to use Pushover. 

Different messaging services, that should be equally easy to implement:

* Slack
* Teams
* Mattermost
* Pushover

What you need:

* A pushover account (at https://pushover.net)
* A pushover user token (you will get that as soon as you create your account)
* A pushover application token (has to be created in the cockpit under "Your Applications")

# Pre reqs

You need mosquitto-clients installed. On Ubuntu:

```
sudo apt-get install mosquitto-clients
```

# How to use:

* Configure your Pushover account (create one, create an application token)
* Configure your ./etc/app.conf (add your mqtt broker ip, user/password, then the pushover user token and the pushover application token)

```
cp etc/app.conf.template etc/app.conf
vi etc/app.conf
```

* Push to messaging service

```
./bin/send_message "my message"
```

* Run the consumer:

```
./bin/consume.sh
```

* Start in the background:

```
nohup ./bin/consume.sh > /dev/null 2>&1 &
```

* Crontab entry to start at boot:

```
@reboot cd /path/to/where/you/cloned/this ; nohup ./bin/consume.sh > /dev/null 2>&1
```

# References

* https://pushover.net/
* https://pushover.net/api
* https://funprojects.blog/2021/05/25/bash-with-mqtt/

