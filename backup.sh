#!/bin/bash

# Define backup directory
backup_dir="/path/to/backup/directory"

# Get a list of volumes with the "sentry-" prefix
volumes=$(docker volume ls --format '{{.Name}}' | grep '^sentry-')

# Create backup directory if it doesn't exist
mkdir -p "$backup_dir"

# Iterate over each volume and create a backup
for volume in $volumes; do
    echo "Creating backup for volume: $volume"
    docker run --rm -v "$volume":/volume -v "$backup_dir":/backup busybox tar -czf "/backup/${volume}.tar.gz" -C /volume .
done

echo "Backup process completed"