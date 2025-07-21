# Monitoring System

This repository contains a bash script and systemd service to monitor a test process in a Linux environment. The script checks the status of a test process, sends HTTP requests to a monitoring endpoint, and logs relevant events.

## Table of Contents
- [Overview](#overview)
- [Requirements](#requirements)
- [Directory Structure](#directory-structure)
- [Deployment](#deployment)
- [Service Management](#service-management)
- [Log Viewing](#log-viewing)
- [Undeployment](#undeployment)

## Overview
The monitoring system is designed to:
- Run at system startup using a systemd unit.
- Execute every minute to check the test process.
- Send an HTTP request to `https://test.com/monitoring/test/api` if the process is running.
- Log process restarts and monitoring server unavailability to `/var/log/monitoring.log`.
- Take no action if the process is not running.

## Requirements
The monitoring script must:
1. Start automatically at system boot (via systemd).
2. Run every minute.
3. Send an HTTPS request to `https://test.com/monitoring/test/api` when the process is active.
4. Log process restarts to `/var/log/monitoring.log`.
5. Log when the monitoring server is unavailable.
6. Do nothing if the process is not running.

## Directory Structure
```
monitoring_systemd_service/
├── deploy.sh              # Script to deploy services
├── undeployment.sh        # Script to undeploy services
├── README.md              # This file
├── scripts/
│   ├── monitoring.sh      # Monitoring script
│   └── test_service.sh    # Infinite loop for test service
└── services/
    ├── monitoring.service # Systemd service for monitoring
    ├── monitoring.timer   # Systemd timer for scheduling
    └── test.service       # Systemd service for test process
```

## Deployment
To deploy the services:
```bash
chmod +x deploy.sh
sudo ./deploy.sh
```

## Service Management
- **Stop the test service:**
  ```bash
  sudo systemctl stop test.service
  ```

- **Restart the test service:**
  ```bash
  sudo systemctl restart test.service
  ```

## Log Viewing
- **View the last 5 lines of the log:**
  ```bash
  cat /var/log/monitoring_service.log | tail -n 5
  ```

- **View the entire log:**
  ```bash
  cat /var/log/monitoring_service.log
  ```

## Undeployment
To undeploy the services:
```bash
chmod +x undeployment.sh
sudo ./undeployment.sh
```