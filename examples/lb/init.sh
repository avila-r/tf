#!/bin/bash

# configure repository for nginx (latest released)
sudo cat << 'EOF' >> /etc/yum.repos.d/nginx.repo
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/amzn2/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
priority=9
EOF

# update system and install nginx
sudo yum update -y && sudo yum install nginx -y

# create sample HTML file
sudo cat << 'EOF' > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<body>

<h1>Hello, World!</h1>
<h2>From: <p id="hostname"></p> </h2>

<script>
let host = location.host;
document.getElementById("hostname").innerHTML = host;
</script>
</body>
</html>
EOF

# enable and start nginx service
sudo systemctl enable nginx --now