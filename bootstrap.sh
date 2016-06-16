#!/usr/bin/env bash
# set -eo pipefail - Disabled as it causes the pyhthon builds to fail part way through
set -x

curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

AVAILABLE=(
  2.5.6
  2.6.9
  2.7.10
  3.2.6
  3.3.6
  3.4.3
)

mkdir -p /mnt/home
export MAKEFLAGS="-j $(grep -c ^processor /proc/cpuinfo)"
for version in "${AVAILABLE[@]}"; do
  pyenv install $version
done

mv /mnt/home/pyenv /opt/pyenv
rm -rf /mnt/home

chown mop:mop -R /opt/pyenv
chmod g-w -R /opt/pyenv
