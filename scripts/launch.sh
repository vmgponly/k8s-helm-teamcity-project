#!/bin/sh

# NOTE: Sync ban device data from NDAS
rails import:device_bans
rails import:device_app_bans

# NOTE: Register the following tasks
# 0 * * * * /bin/bash -l -c 'cd /app && RAILS_ENV=development bundle exec rake import:device_bans --silent >> /app/log/cron.log 2>&1'
# 0 * * * * /bin/bash -l -c 'cd /app && RAILS_ENV=development bundle exec rake import:device_app_bans --silent >> /app/log/cron.log 2>&1'
whenever --set environment=${RAILS_ENV} --update-crontab

crond -l 2 -f
