# LaunchVotes

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

## GitHub API Notes

```
# OAuth2 Token
curl -H "Authorization: token OAUTH-TOKEN" https://api.github.com
curl https://api.github.com/?access_token=OAUTH-TOKEN

# OAuth2 Key/Secret
curl 'https://api.github.com/users/whatever?client_id=xxxx&client_secret=yyyy'

# List user orginizations
GET /users/:username/orgs
GET /user/orgs

# Members of an orginization
GET /orgs/:org/members
```
