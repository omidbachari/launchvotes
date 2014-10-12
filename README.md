# LaunchVotes

A Sinatra/ActiveRecord based app that allows users to nominate each other for awards and vote on them.

## GitHub API

```
# OAuth2 Token
curl -H "Authorization: token OAUTH-TOKEN" https://api.github.com
curl https://api.github.com/?access_token=OAUTH-TOKEN

# OAuth2 Key/Secret
curl 'https://api.github.com/users/whatever?client_id=xxxx&client_secret=yyyy'

# List user orginizations
GET /users/:username/orgs
GET /user/orgs
```
