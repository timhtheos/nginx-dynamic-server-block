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

1. Set default `$dyn_www`.

  Default is `1`.

  | Value | Description                  |
  |-------|------------------------------|
  | 1     | 301 redirects non-www to www |
  | 0     | 301 redirects www to non-www |

  Unfortunately, this feature has not yet been implemented.  The plan for this is
  to include ease override per project.

2. Set default `$dyn_base`.

  Default is `/var/www/sites`.

  Projects are setup within this directory.

3. Set default `$dyn_web`.

  Default is `www`.

  This can be set to other name such as `web`, `public_heml`, among others. This
  directory resides inside the project directory.

## Host directory structure

```
$dyn_base/project-directory/$dyn_web/
```

## Project-specific settings

### 301 redirect non-www to www (if default global setting is otherwise)

    In the project directory, add a file `www+`.  Currently, this is not yet
    implemented.

### 301 redirect www to non-www (if default global setting is otherwise)

    In the project directory, add a file `www-`.
