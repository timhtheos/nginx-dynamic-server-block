# Nginx dynamic server block

I wrote this for my own satisfaction.  I read others' work, and by reading, I
learn from them.

## Installation

1. Copy `dynamic` file into your nginx' sites-available directory that is usually
found in `/etc/nginx/sites-available` directory.

```
cd /etc/nginx/sites-available
sudo wget https://raw.githubusercontent.com/timhtheos/nginx-dynamic-server-block/master/dynamic
```

2. Enable `dynamic` server block. This can be done by symlinking `dyanmic` from
sites-available directory to sites-enabled directory.

```
sudo ln -s /etc/nginx/sites-available/dynamic /etc/nginx/sites-enabled/dynamic
```

3. Restart/reboot nginx.

```
sudo service nginx restart
```

## Global settings

1. Set default use of alias www. The default is `1`, which redirects non-www to
www, otherwise, `0`, which redirects www to non-www.  Note that this can easily
be overridden per host.

2. Set root base path.  Default is `/var/www/sites`. This means projects are
setup within that directory.

3. Set default weebroot directory name. Default is `www`. This can be changed to
other name such as `web`, "public_html", among others. This is one directory down
inside a root host directory.

## Directory structure

/dyn-base
/root-base-path/project-root/webroot


