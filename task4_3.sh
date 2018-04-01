#!/bin/bash

function check_backups_qty () {
  # Find all backups of target_folder in /tmp/backups and check
  # if there are too many of them
  # Returns:
  #   true - there are more backups than allowed
  #   false - there are less backups than allowed
  backed_up_qty=$(find /tmp/backups/ -name "*$arch_name*" | wc -l);
  [[ "$backed_up_qty" -gt "$max_backup_qty" ]] && return
}

# Check if there are 2 command line arguments passed
if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters" >&2
    exit 1
fi

# Assign variables
target_folder="$1"
max_backup_qty="$2"

# Check if target folder exists
if [ ! -d "$target_folder" ]; then
  echo "Taget directory doesn't exist" >&2
  exit 1
fi

# Check if number of backups is valid integer, e.g. 0, 1, 2 etc are valid
# -1, lol, *22 - invalid
if [[ ! $max_backup_qty =~ ^[0-9]+$ ]]; then
  echo "Illegal number of allowed backups" >&2
  exit 1
fi

backup_path="/tmp/backups"

# Create folder for backups if it doesn't exist
if [ ! -d "$backup_path" ]; then
  mkdir "/tmp/backups"
fi

# Get current date in format like 2018-03-01-12-04-05
DATE=`date +"%Y-%m-%d-%H-%M-%S"`

# Make arch_name as /some/path/ => some-path
# To replace slashes to dashes: tr "/" "-"
# To trim the leading dash (if any): sed 's/^-//'
# To trim the trailing dash (if any): sed 's/-$//'
arch_name=$(echo $target_folder | tr "/" "-" | sed 's/^-//' | sed 's/-$//')

# Make a .tar.gz archive
tar -cvzf /tmp/backups/"$arch_name"_"$DATE".tar.gz -C "$target_folder" .

# Check if there are more backups than allowed
while check_backups_qty; do
  oldest_filename=$(find /tmp/backups -type f -printf '%p\n' | sort | grep "$arch_name" | head -n 1)
  rm "$oldest_filename"
done

