# API

### Notes:

* Routes prefixed with '/protected/' need authorization

## Auth

#### Get '/login_url'

returns the url to login using github account

###### Return example:
```javascript
{"url":"https://github.com/login/oauth/authorize?client_id=f978f8e6b6fca4659964\u0026scope=public_repo, user"}
```

#### Get '/protected/profile'

returns a json containing current user information

###### Return example:
```javascript
{
    user: {
        login: "lucasbibiano",
        id: 1474425,
        avatar_url: "https://avatars.githubusercontent.com/u/1474425?v=2",
        gravatar_id: "e03954ed54a988498d9c1f837a7be0e6",
        url: "https://api.github.com/users/lucasbibiano",
        html_url: "https://github.com/lucasbibiano",
        followers_url: "https://api.github.com/users/lucasbibiano/followers",
        following_url: "https://api.github.com/users/lucasbibiano/following{/other_user}",
        gists_url: "https://api.github.com/users/lucasbibiano/gists{/gist_id}",
        starred_url: "https://api.github.com/users/lucasbibiano/starred{/owner}{/repo}",
        subscriptions_url: "https://api.github.com/users/lucasbibiano/subscriptions",
        organizations_url: "https://api.github.com/users/lucasbibiano/orgs",
        repos_url: "https://api.github.com/users/lucasbibiano/repos",
        events_url: "https://api.github.com/users/lucasbibiano/events{/privacy}",
        received_events_url: "https://api.github.com/users/lucasbibiano/received_events",
        type: "User",
        site_admin: false,
        name: "lucasbibiano",
        company: null,
        blog: null,
        location: null,
        email: "lucasbibianodossantos@gmail.com",
        hireable: false,
        bio: null,
        public_repos: 29,
        public_gists: 0,
        followers: 21,
        following: 24,
        created_at: "2012-02-25T23:53:15.000Z",
        updated_at: "2014-09-19T01:09:02.000Z",
        private_gists: 0,
        total_private_repos: 0,
        owned_private_repos: 0,
        disk_usage: 7070,
        collaborators: 0,
        plan: {
            name: "free",
            space: 307200,
            collaborators: 0,
            private_repos: 0
        }
    }
}
```