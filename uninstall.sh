#!/usr/bin/env bash
#
# maintainance-shutdown
#

echo "* Stopping systemd unit files..."
systemctl stop    maintainance-shutdown.timer || exit 1
systemctl disable maintainance-shutdown.timer || exit 1

echo "* Removing systemd unit files..."
rm -f /etc/systemd/system/maintainance-shutdown.* || exit 1

exit 0
