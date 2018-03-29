#!/bin/bash

# Get current date
DATE=`date +%Y-%m-%d`

target_folder='/home/administrator/web/logs/'
final_dir="${target_folder}${1##*/}"
echo "$final_dir"

# Copy target folder to /tmp/backups
cp -r "$target_folder" /tmp/backups/

HITSDIR=`find "/tmp/backups/" -type d | sed -e 's|'$target_folder'\(.*\)|\1|g'`
echo $HITSDIR
# Make arch_name as /some/path/ => some-path
arch_name=$(echo $target_folder | tr "/" "-" | sed 's/\(^-\)\|\(-$\)//')
# more correct echo $target_folder | tr "/" "-" | sed 's/^-\(.*\)$-/\1/'
echo $arch_name
tar -cvzf /tmp/backups/"$arch_name_$DATE".tar.gz "$HITSDIR"
