# Nginx dynamic server block

I read others' work, and by reading others work, I learn from them.

I wrote this for my own satisfaction and need.  I always end up writing server
block(s) in nginx. I always thought of spending some time making it dynamic.

Hence, this.

Server blocks are Apache's virtual host' counterpart.

Note that I have taken
[If Is Evil](https://www.nginx.com/resources/wiki/start/topics/depth/ifisevil/)
into account.

## Why is there a need for dynamic server blocks?

Here are the things I don't want to do, every time I add a new website into the
server.

1. I don't want to duplicate a server block file and rename it to a new website.
2. I don't want to edit the said copied file and change variables there, such as
`root`,`server_name`, `access_logs`, among others.
3. I don't want to symlink the said copied file from sites-available to
sites-enabled.
4. I don't want to restart nginx every time I do the above steps.
5. And I don't want to re-edit the same file, if nginx failed and test with `-t`
and try again.
6. I'm lazy.

## What I want?

1. I just want to perform symlinking a server block once, and restarting nginx
once. P.S. I do restart nginx sometimes, once in a blue moon.
2. I just want to create a directory of the domain name in a proper path and
clone the project inside `www` and check the web browser.

Lazy?

## Manual installation

1. Copy `dynamic` file into your nginx' `sites-available` directory that is usually
found in `/etc/nginx/sites-available`.

  ```
  $ cd /etc/nginx/sites-available
  $ sudo wget https://raw.githubusercontent.com/timhtheos/nginx-dynamic-server-block/master/dynamic
  ```

2. Enable `dynamic` server block. This can be done by symlinking `dyanmic` from
sites-available directory to sites-enabled directory.

  ```
  $ sudo ln -s /etc/nginx/sites-available/dynamic /etc/nginx/sites-enabled/dynamic
  ```

3. Restart/reboot nginx.

  ```
  $ sudo service nginx restart
  ```

## Automated installation

If you trust me enough, go ahead and execute the following.

**Note that you must be root in order to do this. The following command has been
tested with Ubuntu 14.04. Try at your own risk.**

```
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/timhtheos/nginx-dynamic-server-block/master/install.sh)"
```

## Global settings (optional)

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

  This can be set to other name such as `web`, `public_html`, among others. This
  directory resides inside the project directory.

## Definition of other terms

| Term | Definition |
|---|---|
| Project name | The project name shall be the project directory created inside `$dyn_base` directory. It contains a directory named matched to `$dyn_web` and may also contain build scripts and directories, and other files/directories. The Project name shall be at all times the domain name of the site, minus the alias `www` irrespective of the global settings for `$dyn_www`.  The same rule applies to subdomain names. |
| Project directory | See Project name. |

## Host directory path structure

```
$dyn_base/project-name-directory/$dyn_web/
```

#### Examples

```
/var/www/sites/example.com/www
/var/www/sites/demo.com/www
```

## How to setup a project?

Let's assume the global settings are in default; and the project name is
`github.com`.

1. Create a directory inside `/var/www/sites`. The directory name shall be the
domain or subdomain name of the project, minus the alias `www`.

  ```
  $ cd /var/www/sites;
  $ mkdir github.com
  ```

2. Create a directory `www` inside the project directory.

  ```
  $ mkdir -p github.com/www
  ```

3. (optional) Create `index.html` file inside `www`, and check the url in your
browser.

  ```
  $ echo "Hello World\!" >> github.com/www/index.html
  ```

## Project-specific settings

#### 301 redirect non-www to www (if default global setting is otherwise)

  In the project directory, add a file `www+`.  Currently, this is not yet
  implemented.

#### 301 redirect www to non-www (if default global setting is otherwise)

  In the project directory, add a file `www-`.

## @todo

1. Revise this fucking README.md file.
2. Improve naming convention for variables used.
3. Include features for choice of php version.
