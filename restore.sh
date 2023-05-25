#!/bin/bash

# Define backup directory
backup_dir="/path/to/backup/directory"

# Get a list of backup files in the backup directory
backup_files=$(find "$backup_dir" -type f -name "*.tar.gz")

# Iterate over each backup file and restore the volume
for file in $backup_files; do
    # Extract volume name from the backup file name
    volume=$(basename "$file" | cut -d '.' -f 1)
    echo "Restoring volume: $volume"

    # Create a temporary container and restore the backup
    docker run --rm -v "$volume":/volume -v "$backup_dir":/backup busybox tar -xzf "/backup/$(basename "$file")" -C /volume
done

echo "Data restore process completed"
