---
title: "Obsidian Livesync: The Followup"
date: 2025-01-27T11:37:22Z
draft: false
---

It's been a while since I published my original post on [how to configure Obsidian LiveSync with self-hosted CouchDB](/posts/obsidian-livesync/) - and many things have changed since then; in particular, I moved away from using this approach in favour of using GitHub - relatively rare merge conflicts are totally outweighted by the fact that I have read/write-able version of my notes in the browser, and can access them without Obsidian app at all. Other users, however, disagreed - for example, awesome [Kate Evangelista](https://github.com/ckevangelista) recently sent me an email with a number of corrections to my original post. I figured it would only be fair to publish it as is, with direct attribution. Therefore, without further ado ...

<hr/>

Hello!

I spent some time in the past week working on getting my own Obsidian Livesync CouchDB server running using your very helpful guide. My server lives in Oracle Cloud (Always Free Tier). Thank you very much!

I have some suggestions that you might like to add to your blog post to help others get theirs working too. 

The first block I encountered was: What permissions do I need to grant for the Cloudflare API Token? After reading the .env section more closely, I decided to give only the Zone: DNS: Edit permission. I did not have any trouble with it later.

The next block came after running docker compose up. CouchDB was looking for the _users database. I fixed my setup by opening another terminal and running a curl commands to create the system databases (_users, _replicator, _global_changes) while Docker containers are running. 
Could you make modifications to the docker-compose YAML file to create these databases automatically?

> RK: I have no recollection of ever creating these tables manually - IIRC they were created by LiveSync itself?

```
curl -X PUT https://obsidian_couchdb_user:<your-password-here>@my.host.name.com:5984/_users
curl -X PUT https://obsidian_couchdb_user:<your-password-here>@my.host.name.com:5984/_replicator
curl -X PUT https://obsidian_couchdb_user:<your-password-here>O@my.host.name.com:5984/_global_changes
```

My next suggestion is to tell the readers about running docker compose in detached mode using the -d flag so that the docker containers can run in the background.

```
docker compose up -d
```

> RK: d'oh. Well spotted!

After that I was able to connect to the database from my Obsidian Desktop. But I could not connect from Android/mobile. This got me stumped for a while until I saw some forums asking about the same issue talking about Origin Headers.

> RK: This is a bit which puzzled myself as well - I could never make it _quite_ work!

vrtmrz himself, the author of Obsidian Livesync, has a short guide to help debug errors in livesync: https://forum.obsidian.md/t/self-hosted-livesync-ex-obsidian-livesync-released/26673/30
The trouble with obsidian livesync in Android is that the origin header used is not app:obsidian.md but http://localhost. (Sorry, I did not copy the error message.)
I fixed this by researching a little into couchdb documentation to find solutions for allowing connections from multiple possible origins.
Couchdb CORS settings seem to allow that already. So I looked into Caddy. I saw in your original guide's Caddyfile that only app://obsidian.md is allowed through. I looked for ways to allow requests from multiple origins and found this: https://caddy.community/t/define-multiple-access-control-allow-origin/19702

My Caddyfile looks like this after a bit of fiddling. I don't need the complicated regexp as my origin headers are fixed strings.

```
  my.host.name.com :5984 {
        reverse_proxy couchdb:5984
        tls {
            dns cloudflare {env.CLOUDFLARE_API_TOKEN}
        }

        @allowedOrigin expression `{http.request.header.Origin}.matches('app://obsidian.md') ||
                        {http.request.header.Origin}.matches('http://localhost') ||
                        {http.request.header.Origin}.matches('capacitor://localhost')
        `
        header {
            Access-Control-Allow-Origin {http.request.header.Origin}
            Access-Control-Allow-Methods "GET, POST, PUT, DELETE, OPTIONS"
            Access-Control-Allow-Headers "Content-Type, Authorization"
            Access-Control-Allow-Credentials "true"
            Access-Control-Max-Age 86400
        }
       
        @cors_preflight {
            method OPTIONS
            header Origin app://obsidian.md
        }
        handle @cors_preflight {
            respond "OK" 204
        }
    }
```

Connecting from mobile still doesn't work but something about this works better already because the errors are showing something else:

`[Connection to host server ...]` has been blocked by CORS policy: Response to preflight request doesn't pass access control check: It does not have HTTP ok status.

After spending more time stumped, I tried running curl commands from Windows to Couchdb to get more information. I noticed that the return messages have duplicate origin headers. Also looking at the last section of the Caddyfile above, I figured that must be where the HTTP OK status should be coming from. More searches on the internet also point to having issues with CORS.

My solution was to turn off CORS in Couchdb and let Caddy handle the CORS requests. This will remove the origin headers duplication issue because it seems that both CouchDB and Caddy are sending origin headers.
I ran the couchdb config Check using the admin user to check the CouchDB configuration just once. Turning off CouchDB Cors will show errors so I'm ignoring the Check button from now on.

```
    my.host.name.com :5984 {
        reverse_proxy couchdb:5984
        tls {
            dns cloudflare {env.CLOUDFLARE_API_TOKEN}
        }

        @allowedOrigin expression `{http.request.header.Origin}.matches('app://obsidian.md') ||
                        {http.request.header.Origin}.matches('http://localhost') ||
                        {http.request.header.Origin}.matches('capacitor://localhost')
        `
        header {
            Access-Control-Allow-Origin {http.request.header.Origin}
            Access-Control-Allow-Methods "GET, POST, PUT, DELETE, OPTIONS"
            Access-Control-Allow-Headers "Content-Type, Authorization"
            Access-Control-Allow-Credentials "true"
            Access-Control-Max-Age 86400
        }
       
        @cors_preflight {
            method OPTIONS
        }
        handle @cors_preflight {
            respond "OK" 204
        }
    }
```

I simply removed the `header Origin app://obsidian.md` line from the @cors_preflight section.
Perhaps you can think of a better way to handle the preflight headers?

Maybe you know how to change this so that CouchDB handles CORS requests instead of Caddy. Do you think that would be more elegant? I'm not a Caddy or CouchDB expert in any way, but at least I got to tell you about the issue I ran into.

> RK: Technically, LiveSync is capable of self-checking CouchDB configuration and sorting it out
> for itself, but practically it never really worked form.

After this, my setup works wonderfully on Windows, Android, and even on IOS, because Caddy accepts requests with all origin headers indicated in vrtmrz's original configuration.

One other thing I wanted to get working: allow multiple users to use the same CouchDB server but have independent databases and with no interference between each other. I created the user in the _users. Then, I created each vault database using the CouchDB Project Fauxton web page. Lastly, I added the concerned user as a database admin to grant permissions. As I noted above how I chose to ignore configuration checking, I continued ignoring it to use a non-admin Couchdb user in the database connection. A non-admin Couchdb user will not be able to run the config check at all. After configuring connection with this non-admin user and the created database, connections and syncing continued working. 😁 Running some maintenance commands from Livesync's Maintenance tab will not work with the non-admin user because admin user rights are required, but I'll cross the bridge when I get there.

Again, thank you so much! I do not know how long I will continue using it. Maybe it can get too cumbersome for me down the line, but I can't tell right now. I am also offering it to a friend to use for free. I am very glad to have this option.

> RK: [Kate](https://github.com/ckevangelista) - many thanks for your awesome analysis and the write-up. Given how much feedback I received on that post, I'm sure it'll help many people. As for me, like I said above, I switched to GitHub-backed repo. It still doesn't really work properly on Android, but then again my usage pattern means Obsidian notes are only used on "proper" devices (yes I'm that old). Anyway, thank you again!