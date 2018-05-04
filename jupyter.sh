#!/bin/bash

# Exit this script if any error is encountered (e) and print every command (x)
set -ex

# Run as unprivileged user but with host UID and GID inside docker container
if [ $UID -eq 0 ]; then
  vol=$(ls -l "$0")
  uid=$(echo "$vol" | awk '{print $3}')
  if [ "$uid" = root ]
  then
    uid=1000
  fi
  gid=$(echo "$vol" | awk '{print $4}')
  if [ "$gid" = root ]
  then
    gid=1000
  fi
  groupadd -g "$gid" "$USER"
  useradd -g "$gid" -u "$uid" -s /bin/bash -G root,sudo,plugdev -m "$USER"
  passwd -d "$USER" >/dev/null
  touch /home/"$USER"/.sudo_as_admin_successful
  chown -R "$USER:$USER" /home/"$USER"
  su -c "export PATH=$PATH; /bin/bash $0" "$USER"
  exit &>/dev/null
fi

# Start jupyter notebook server inside /notebooks folder using volume user ID
jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token='researchlab'
