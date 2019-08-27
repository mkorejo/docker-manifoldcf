#!/bin/bash

ps -ef | grep AgentRun | grep /usr/local/openjdk-8/bin/java
if [ $? -ne 0 ]; then exit 1; fi

curl -L --max-time 3 http://localhost:8345/mcf-crawler-ui
if [ $? -ne 0 ]; then exit 1; fi
