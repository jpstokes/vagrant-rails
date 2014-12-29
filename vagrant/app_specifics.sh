#!/bin/sh
# Original script on https://github.com/orendon/vagrant-rails

# load rbenv and shims
export RBENV_ROOT="${HOME}/.rbenv"
export PATH="${RBENV_ROOT}/bin:${PATH}"
export PATH="${RBENV_ROOT}/shims:${PATH}"

cd /vagrant
bundle install
rbenv rehash
cp -R config/database.sample.yml config/database.yml
