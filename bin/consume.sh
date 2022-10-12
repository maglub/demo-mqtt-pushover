#!/bin/bash

this_path=$(cd $(dirname $0); pwd)

. $this_path/../etc/app.conf

mqtt_host=${mqtt_host:-192.168.4.81}
mqtt_user=${mqtt_user:-mqtt}
mqtt_password=${mqtt_password:-supersecret}

#--- topic to listen for
mqtt_topic=${mqtt_topic:-my/topic/path/x}
notification_type=${notification_type:-pushover}

echo "Topic: $mqtt_topic"

while true
do
  value=$(mosquitto_sub -C 1 -h $mqtt_host -u $mqtt_user -P $mqtt_password -t $mqtt_topic)
  echo "Received: $value on topic: $mqtt_topic"

  case $value in
    1)
       echo "  - Running external command: send_message"
       $this_path/send_message.${notification_type} "door bell"
       ;;
    *)
       echo "Unknown value: $value"
       ;;
  esac
done
