# Monitoring System / Система мониторинга

This repository contains a bash script and systemd service to monitor a test process in a Linux environment. The script checks the status of a test process, sends HTTP requests to a monitoring endpoint, and logs relevant events.

В этом репозитории содержится bash-скрипт и systemd-служба для мониторинга тестового процесса в среде Linux. Скрипт проверяет статус тестового процесса, отправляет HTTP-запросы на конечную точку мониторинга и записывает соответствующие события в лог.

## Table of Contents / Содержание
- [Русская версия](#русская-версия)
  - [Требования](#требования)
  - [Структура директорий](#структура-директорий)
  - [Развертывание](#развертывание)
  - [Управление службами](#управление-службами)
  - [Просмотр логов](#просмотр-логов)
  - [Удаление служб](#удаление-служб)
- [English Version](#english-version)
  - [Requirements](#requirements)
  - [Directory Structure](#directory-structure)
  - [Deployment](#deployment)
  - [Service Management](#service-management)
  - [Log Viewing](#log-viewing)
  - [Undeployment](#undeployment)

## Русская версия
### Требования
Скрипт мониторинга должен:
1. Запускаться автоматически при загрузке системы (через systemd).
2. Выполняться каждую минуту.
3. Отправлять HTTPS-запрос на `https://test.com/monitoring/test/api`, если процесс работает.
4. Логировать перезапуски процесса в `/var/log/monitoring.log`.
5. Логировать недоступность сервера мониторинга.
6. Не предпринимать действий, если процесс не запущен.

### Структура директорий
```
monitoring_systemd_service/
├── deploy.sh              # Скрипт для развертывания служб
├── undeployment.sh        # Скрипт для удаления служб
├── README.md              # Этот файл
├── scripts/
│   ├── monitoring.sh      # Скрипт мониторинга
│   └── test_service.sh    # Бесконечный цикл для тестовой службы
└── services/
    ├── monitoring.service # Systemd-служба для мониторинга
    ├── monitoring.timer   # Systemd-таймер для планирования
    └── test.service       # Systemd-служба для тестового процесса
```

### Развертывание
Для развертывания служб:
```bash
chmod +x deploy.sh
sudo ./deploy.sh
```

### Управление службами
- **Остановка тестовой службы:**
  ```bash
  sudo systemctl stop test.service
  ```

- **Перезапуск тестовой службы:**
  ```bash
  sudo systemctl restart test.service
  ```

### Просмотр логов
- **Просмотр последних 5 строк лога:**
  ```bash
  cat /var/log/monitoring_service.log | tail -n 5
  ```

- **Просмотр всего лога:**
  ```bash
  cat /var/log/monitoring_service.log
  ```

### Удаление служб
Для удаления служб:
```bash
chmod +x undeployment.sh
sudo ./undeployment.sh
```

## English Version
### Requirements
The monitoring script must:
1. Start automatically at system boot (via systemd).
2. Run every minute.
3. Send an HTTPS request to `https://test.com/monitoring/test/api` when the process is active.
4. Log process restarts to `/var/log/monitoring.log`.
5. Log when the monitoring server is unavailable.
6. Do nothing if the process is not running.

### Directory Structure
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

### Deployment
To deploy the services:
```bash
chmod +x deploy.sh
sudo ./deploy.sh
```

### Service Management
- **Stop the test service:**
  ```bash
  sudo systemctl stop test.service
  ```

- **Restart the test service:**
  ```bash
  sudo systemctl restart test.service
  ```

### Log Viewing
- **View the last 5 lines of the log:**
  ```bash
  cat /var/log/monitoring_service.log | tail -n 5
  ```

- **View the entire log:**
  ```bash
  cat /var/log/monitoring_service.log
  ```

### Undeployment
To undeploy the services:
```bash
chmod +x undeployment.sh
sudo ./undeployment.sh
```