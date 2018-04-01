# task4_3
DevOps course

## Installation
```
git clone https://github.com/al-serebrov/task4_3
```

## Usage
```
$ bash task4_3.sh /path/to/taget_folder number_of_backups
```
The first command line argument is path to target folder (of which backups would be made)
The sesond command line argument is for allowed number of backups.
For example:

```
$ bash task4_3.sh /home/user/important_folder 4
```

At the first launch there would be:
- Created folder `/tmp/backups` if it doesn't exict
- Created a `.tar.gz` archive of `important_folder` in a format: `imporatant_folder_DATE` 
  where DATE is in format "YYYY-mm-dd-HH-MM-SS"

Any consequent launch with the same arguments will create one more `.tar.gz` archive in `/tmp/backups`, up to `4` this case. If there are already 4 archives in `/tmp/backups` for `/important_folder`, the oldest one would be deleted to keep quantity of archives equal to the second command line argument.
