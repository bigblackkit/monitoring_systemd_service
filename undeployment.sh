#!/bin/bash

###############################################################################
#                                                                             #
#  🛠️  Undeploy Script for Monitoring Systemd Services                         #
#                                                                             #
#  📌 Description:                                                            #
#   This script cleanly removes all components deployed by the                #
#   deploy.sh script. It stops and disables the systemd services               #  
#   and timer, deletes related unit files from /etc/systemd/system,           # 
#   removes monitoring scripts from /usr/local/bin, and refreshes              #
#   systemd state.                                                            #
#                                                                             #
#  👤 Author:    BigBlackKit                                                   #
#  🗓️  Created:   2025-07-21                                                  #
#  💬 Contact:   bigblackkit@gmail.com                                       #
#                                                                             #
###############################################################################

# List of files to delete
FILES_TO_REMOVE=(
  /etc/systemd/system/test.service
  /etc/systemd/system/monitoring.service
  /etc/systemd/system/monitoring.timer
  /usr/local/bin/test_service.sh
  /usr/local/bin/monitoring.sh
  /var/log/monitoring_service.log
)

echo "### Deleting files... ###"

for FILE in "${FILES_TO_REMOVE[@]}"; do
  if [ -f "$FILE" ]; then
    echo "Deleting: $FILE"
    rm -f "$FILE"
  else
    echo "File not found: $FILE"
  fi
done

echo "### Cleaning up systemd states ###"
systemctl daemon-reload
systemctl reset-failed

echo "### Disable services if they were activated ###"
systemctl disable test.service || true
systemctl disable monitoring.service || true
systemctl disable monitoring.timer || true

echo "### Removal complete ###"