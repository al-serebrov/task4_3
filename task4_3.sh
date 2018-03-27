#!/bin/bash

$target_folder="/home/administrator/web/logs/"
cp -rf "$target_folder" /tmp/backups/

arch_name=$(echo $target_folder | tr "/" "-" | sed 's/^-\(.*\)-$/\1/')

