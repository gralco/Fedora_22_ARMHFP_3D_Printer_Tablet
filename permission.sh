#!/bin/bash

# Eric's fancy script for setting the /dev/ttyACM* serial file's permission.
# The udev rules cannot be properly restarted since the service depends on
# systemd to in order to reload the rules. For essentially the same reason
# (systemd) this script cannot be placed in /etc/rc.local or /etc/init.d/

dir=/dev/

sudo chmod 0666 "$dir"ttyACM* && sudo chown root:dialout "$dir"ttyACM* # if its already connected

inotifywait -m "$dir" --format '%w%f' -e create |
    while read file; do
        sudo chmod 0666 "$dir"ttyACM* && sudo chown root:dialout "$dir"ttyACM*
    done
