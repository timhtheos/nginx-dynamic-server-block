# Nginx dynamic server block

I read others' work, and by reading others work, I learn from them.

I wrote this for my own satisfaction and need.  I always end up writing server
block(s) in nginx, and because I am lazy, I just spent some time making it
dynamic.

Server blocks are Apache's virtual host' counterpart.

Note that I have read
[If Is Evil](https://www.nginx.com/resources/wiki/start/topics/depth/ifisevil/).

## Why is there a need for a dynamic server blocks?

Simple. Here are the things I don't want to do, every time I add a new website
into the server.

1. I don't want to duplicate a server block file and rename it to a new website.
2. I don't want to edit the said copied file and change variables there, such as
`root`,`server_name`, `access_logs`, among others.
3. I don't want to symlink the said copied file from sites-available to
sites-enabled.
4. I don't want to restart nginx every time I do the above steps.
5. And I don't want to re-edit the same file, if nginx failed and test with `-t`
and try again.
6. I am lazy.

## What I want?

1. I just want to perform symlinking a server block once, and restarting nginx
once. P.S. I do restart nginx sometimes, once in a blue moon.
2. I just want to create a directory of the domain name in a proper path and
clone the project inside `www` and check the web browser.

Lazy?

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

## Definition of other terms

| Term | Definition |
|---|---|
| Project name | The project name shall be the project directory created inside `$dyn_base` directory. It contains a directory named matched to `$dyn_web` and may also contain build scripts and directories, and other files/directories. The Project name shall be at all times the domain name of the site, minus the alias `www` irrespective of the global settings for `$dyn_www`.  The same rule applies to subdomain names. |
| Project directory | See Project name. |

## Host directory structure

```
$dyn_base/project-directory/$dyn_web/
```

#### Examples

```
/var/www/sites/example.com/www
/var/www/sites/demo.com/www
```

## How to setup a project

1. Simple. Just create a directory inside your $dyn_base directory. For example,
if your $dyn_base is `/var/www/sites` and your project is `github.com`, just
create a directory inside `/var/www/sites` named `github.com` to become
`/var/www/sites/github.com`.

2. Then, create a directory matched to `$dyn_web`.  For example, if your $dyn_web
is `public_html`, plus the variables in the given example in No. 1, you should
have the following structure: `/var/www/sites/github.com/public_html`.

To test, place a file `index.html` inside your `public_html` and view it in a
browser.

Note that there is no need to restart nginx, et. al.

Note further that the project name shall be the domain name minus the `www`
irrespective of your global and project-specific setting(s) for `$dyn_www`.

In the given example, `github.com` directory can opt to have non-www 301
redirect to www.

For subdomain names, just still create the directory matching the subdomain name.

The default global $dyn_www setting is not so subdomain name friendly.  This
can be overridden in project level. Just create another file named `www-` inside
the project directory, and a subdomain with a `www` before it will be 301
redirected to its non-www.

## Project-specific settings

#### 301 redirect non-www to www (if default global setting is otherwise)

  In the project directory, add a file `www+`.  Currently, this is not yet
  implemented.

#### 301 redirect www to non-www (if default global setting is otherwise)

  In the project directory, add a file `www-`.

## @todo

1. Revise this fucking README.md file.
2. Improve naming convention for variables used.
