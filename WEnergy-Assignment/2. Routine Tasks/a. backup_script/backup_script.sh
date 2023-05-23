#!/bin/bash

# Set the number of files to keep for retention
RETENTION_COUNT=${1:-8}

# Create the backup directory if it doesn't exist
mkdir -p ./backups

# Create the filename based on the current timestamp in UTC
TIMESTAMP=$(date -u +"%Y%m%d-%H%M%S")
FILENAME="q1-backup-${TIMESTAMP}.zip"

# Zip all the files in the ./data directory
zip -r "./backups/${FILENAME}" ./data/*

# Change to the data directory
cd ./data || exit

# List all the files in the directory and sort them alphanumerically
files=(*)
IFS=$'\n' sorted_files=($(sort <<<"${files[*]}"))
unset IFS

# Determine the number of files to delete based on the retention count
delete_count=$((${#sorted_files[@]} - RETENTION_COUNT))

# Delete the oldest files exceeding the retention count
if [[ $delete_count -gt 0 ]]; then
  for ((i = 0; i < delete_count; i++)); do
    rm "${sorted_files[i]}"
  done
fi