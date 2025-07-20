#!/bin/bash

###############################################################################
#                                                                             #
#  🛠️  Deploy Script for Monitoring Systemd Services                          #
#                                                                             #
#  📌 Description:                                                            #
#  This script copies monitoring scripts and systemd service files,          #
#  sets permissions, reloads systemd, starts services, and enables timers.   #
#                                                                             #
#  👤 Author:    BigBlackKit                                                   #
#  🗓️  Created:   2025-07-21                                                  #
#  💬 Contact:   bigblackkit@gmail.com                                       #
#                                                                             #
###############################################################################

set -e

############### Copy Scripts to /usr/local/bin/ ###############

cp scripts/monitoring.sh /usr/local/bin/
cp scripts/test_service.sh /usr/local/bin/

############### Add execute permission to scripts ###############

chmod +x /usr/local/bin/monitoring.sh
chmod +x /usr/local/bin/test_service.sh

############### Copy Services to /etc/systemd/system/ ###############

cp services/test.service /etc/systemd/system/
cp services/monitoring.service /etc/systemd/system/
cp services/monitoring.timer /etc/systemd/system/

############### Rereads/Enable/Start/Status ###############

systemctl daemon-reload
systemctl start test.service
systemctl start monitoring.service
systemctl start monitoring.timer
systemctl enable test.service
systemctl enable monitoring.service
systemctl enable monitoring.timer
systemctl status test.service --no-pager
systemctl status monitoring.service --no-pager
systemctl status monitoring.timer --no-pager