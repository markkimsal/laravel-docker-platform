# laravel-docker-platform
Docker container for Laravel and PHP projects.  Graceful shutdown.  No-python supervisor. No-SSH.

# NGINX-FPM Images

Update the all Dockerfiles
```
php ./make-versions.php
```

Build a single image images with
```
bash ./build-image.sh 8.0
```

# PHP Extensions
I found that each extension barely takes up any more disk space or memory.  If you don't want them, attach blank files
to the container ini files when you deploy.


|PHP Version - flavor |  7.3-nginx-fpm |  7.3-tools | 7.4-nginx-fpm | 7.4-tools | 8.0-nginx-fpm | 8.0-tools |
|----------|----------|-----------------|-----|-----|-----|-----|
| BCMATH               | X |  X | X | X | X |  X |
| Intl                 | X |  X | X | X | X |  X |
| gd                   | X |  X | X | X | X |  X |
| mysql                | X |  X | X | X | X |  X |
| pgsql                | X |  X | X | X | X |  X |
| sqlite3              | X |  X | X | X | X |  X |
| readline             | X |  X | X | X | X |  X |
| memcached (igbinary) | X |  X | X | X | X |  X |
| redis                | X |  X | X | X | X |  X |
| xdebug               | X |  X | X | X | X |  X |
| zip                  | X |  X | X | X | X |  X |
| SOAP                 | X |  X | X | X | X |  X |
| SSH2                 | X |  X | X | X | X |  X |
| pcntl                | X |  X | X | X | X |  X |
| lib sodium           | X |  X | X | X | X |  X |
| nginx                | X |  X | X | X | X |  X |
| yarn                 |   |  X |   | X |   |  X |
| nodejs-14.x          |   |  X |   | X |   |  X |
| composer2            |   |  X |   | X |   |  X |
| composer1.10         |   |  X |   | X |   |  X |
| deployer             |   |  X |   | X |   |  X |
| altax                |   |  X |   | X |   |  X |
| git                  |   |  X |   | X |   |  X |
| unzip                |   |  X |   | X |   |  X |


# Tools images
Having an image that can also run tests and build your image as part of your CI pipeline is useful.  I could not find an
image of nodejs that also had git, and at least one of my node dependencies required git to install so... here we are with
nodejs 14 baked into this image.

Sometimes composer complains when you don't have a host OS `unzip` program, so that's been added to the tools variant.

Also, for deploying with PHP deployer, I found that having ssh, unzip, git are usefull or required.

I used to use `altax` for remote deployment so that's also on there.


# Supervisor runit
Runit is a small, c process supervisor.  It tries to restart failed processes until you tell it to stop.  The problem with runit
is that you cannot send a signal that will gracefully stop all managed services.  You must stop all services "by-hand", which is 
weird.  You'd think that a simple SIGSTOP could initiate a graceful shutdown, but there's no way to do this.  Runit (or runsv or runsvdir) will
respond to TERM signals mostly by dieing immediately and letting children float to PID 1 and get reaped.

There is a small bash file that - in combination with `dumb-init` - will act as pid 1, take `docker stop` SIGQUIT or SIGTERM and gracefully try
to shutdown the running services.  This is essentially what the `/sbin/my_init` program from phusion/baseimage does.


