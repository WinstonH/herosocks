# Herosocks
Heroku + shadowsocks \
Deploy shadowsocks on heroku
## Principle
Simple-obfs convert the traffic into websocket instead of ordinary tcp connection, which could serve behind nginx. \
Theoretically, this enables ss-server to use any CDN that support websocket traffic, for example, Cloudflare.
## One-Click button
[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)
## How to use
Host: <app_name>.herokuapp.com \
Port: 80 \
Plug-in: simple-obfs \
Plug-in-options: obfs=http;obfs-host=<app_name>.herokuapp.com
## Note
This trick heavily rely on the domain of herokuapp.com. \
Please do not distribute this repo everywhere in case the domain is blocked.
## Demo
Feel free to use but make sure you obey the Note part mentioned above. \
![](https://github.com/WinstonH/herosocks/blob/master/img/demo.png)
