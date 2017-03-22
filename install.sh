#!/bin/bash

# Check if user is root.
if [[ $USER != "root" ]]; then
  echo "You must to be root to proceed. See README.md for details.";
  exit 1;
fi

# Download nginx dynamic server block.
wget https://raw.githubusercontent.com/timhtheos/nginx-dynamic-server-block/master/dynamic;

# Move to sites-available.
mv dynamic /etc/nginx/sites-available/;

# Enable dynamic.
ln -s /etc/nginx/sites-available/dynamic /etc/nginx/sites-enabled/dynamic;

# Restart nginx.
service nginx restart;

echo "You have successfully installed nginx dynamic server block.";
