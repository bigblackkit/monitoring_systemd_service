#!/bin/bash

###############################################################################
#                                                                             #
#  🛠️  Script for Monitoring Systemd Services and  URL                         #
#                                                                             #
#  📌 Description:                                                            #
#  This script monitors test.service and writes about its status to the log.   #
#  This script also knocks on the URL and writes about the results to the log.  #
#                                                                             #
#  👤 Author:    BigBlackKit                                                   #
#  🗓️  Created:   2025-07-21                                                  #
#  💬 Contact:   bigblackkit@gmail.com                                       #
#                                                                             #
###############################################################################


##### Variables #####
URL="https://test.com/monitoring/test/api"
LOGFILE="/var/log/monitoring_service.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 "$URL")
SERVICE="test.service"
PID_FILE="/tmp/test_monitoring.pid"
STOP_TIME=$(journalctl -u test.service --grep="Stopped" -n 1 --no-pager --output=short | awk '{print $1, $2, $3}')
RESTART_TIME=$(systemctl show -p ExecMainStartTimestamp --value "$SERVICE")

#### Check Restart Service ####

CURRENT_PID=$(systemctl show -p MainPID --value "$SERVICE")
if [[ "$CURRENT_PID" -ne 0 ]]; then
    if [[ -f "$PID_FILE" ]]; then
        LAST_PID=$(cat "$PID_FILE")
        if [[ "$CURRENT_PID" != "$LAST_PID" ]]; then
        echo "[$TIMESTAMP] - $SERVICE was restarted. Service start time: $RESTART_TIME" >> "$LOGFILE"
        fi
    fi
    echo "$CURRENT_PID" > "$PID_FILE"
fi

#### When the test service is active, Knock on the URL / When the test service stops, write to the log when it stops OR do nothing ####

if systemctl is-active --quiet test.service; then
   
    if [[ -n "$HTTP_STATUS" && "$HTTP_STATUS" =~ ^[0-9]{3}$ && "$HTTP_STATUS" != "000" ]]; then   
        STATUS_MSG="HTTP $HTTP_STATUS"
    else 
        STATUS_MSG="NO RESPONSE"
    fi
    echo "[$TIMESTAMP] GET $URL — status: $STATUS_MSG" >> "$LOGFILE"
else
    echo "[$TIMESTAMP] - $SERVICE is stopped. Service stop time: $RESTART_TIME" >> "$LOGFILE" # I think it will be better with this line, because then you can understand that the service has stopped
    exit 0
fi