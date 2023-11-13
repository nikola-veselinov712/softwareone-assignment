#!/bin/bash

cat > index.html <<EOF
<h1>${server_text}</h1>
<p>DB address: ${db_address}</p>
<p>DB port: ${db_port}</p>
EOF

sudo apt-get update
sudo apt-get install -y mysql-client
# apt install mariadb-client-core-10.3 >> index.html
mysql --version >> index.html
mysql -h ${db_address} -u xxxxxxxxx -pxxxxxxxxx  -P ${db_port}

nohup busybox httpd -f -p ${server_port} &