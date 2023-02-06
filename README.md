# rwweb2

This repository helps people grant root access and does various deployments in configured containers that only expose one HTTP service port by some famous Cloud Service Providers like Okteto, Heroku and Railway.

This repository helps people grant root access and does various deployments in configured containers that only expose one HTTP service port by some famous Cloud Service Providers like Okteto, Heroku and Railway.
In the Building process, I used Alpine, an operating system aimed to be lightweight and fast. Above that are npm, screen, and caddy. And in the deploying process, the "start.sh" first downloaded a pack of website source code from a specific server. After that, we will start the wstunnel on port 8989. In the end, an easy-to-use reverse proxy client -- caddy helps to proxy the wstunnel from the public port.
When you want to log in, first use wstunnel locally to connect to "<public addr>/wst"; then, you'll gain access to the ssh of the container. After that, you can do what you want!
  Command on your machine: 
      wstunnel -t 7001:127.0.0.1:22 --proxy http://127.0.0.1:10809 wss://*****-production.up.railway.app/wst
  
