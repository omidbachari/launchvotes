# LaunchVotes

[![Build Status](https://travis-ci.org/omidbachari/launchvotes.svg?branch=master)](https://travis-ci.org/omidbachari/launchvotes) [![Code Climate](https://codeclimate.com/github/omidbachari/launchvotes.png)](https://codeclimate.com/github/omidbachari/launchvotes) [![Coverage Status](https://coveralls.io/repos/omidbachari/launchvotes/badge.svg)](https://coveralls.io/r/omidbachari/launchvotes)

A Sinatra/ActiveRecord based app that allows users to nominate each other for awards and vote on them.

## Setup git Remotes
```
git remote add fork git@github.com:<your_username>/launchvotes.git
git remote add origin git@github.com:omidbachari/launchvotes.git
git remote add staging git@heroku.com:launchvotes-staging.git
git remote add production git@heroku.com:launchvotes.git
```

## Copy LaunchVotes-Production Database to Development
```
heroku pgbackups:capture --remote production
curl -o db/dumps/latest.dump `heroku pgbackups:url --remote production`
pg_restore --verbose --clean --no-acl --no-owner -h localhost -d launchvotes_development db/dumps/latest.dump
```
