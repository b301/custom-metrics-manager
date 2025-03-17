#!/bin/bash

sleep 10        # checking on-failure handler
echo "$(date)" >> /tmp/docker-status-code.prom
