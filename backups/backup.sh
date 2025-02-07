#!/bin/bash

# Директория сайта
SITE_DIR="/var/www/foilrent"

# Директория для хранения бэкапов
BACKUP_DIR="/var/foilrent/backups"

# Название бэкапа с датой
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="backup_$TIMESTAMP.tar.gz"

# Архивируем файлы сайта
tar -czf "$BACKUP_DIR/$BACKUP_NAME" -C "$SITE_DIR" .

# Ограничиваем количество бэкапов (например, храним только 7 последних)
find "$BACKUP_DIR" -type f -name "backup_*.tar.gz" -mtime +7 -delete

rclone copy /var/foilrent/backups gdrive:/backups --progress

