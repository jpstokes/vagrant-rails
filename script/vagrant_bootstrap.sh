#!/bin/sh
# Original script on https://github.com/orendon/vagrant-rails

# enable console colors
sed -i '1iforce_color_prompt=yes' ~/.bashrc

# disable docs during gem install
echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc

# essentials
sudo apt-get -y update
sudo apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev libcurl4-openssl-dev curl wget

# SQLite, Git and Node.js
sudo apt-get install -y libsqlite3-dev git nodejs

# Qt and xvfb-run for Capybara Webkit
sudo apt-get install -y libqtwebkit-dev xvfb

# ImageMagick and Rmagick
sudo apt-get install -y imagemagick libmagickwand-dev

# Postgres
sudo apt-get install -y postgresql-9.4 postgresql-server-dev-9.4 postgresql-contrib-9.4
sudo sudo -u postgres psql -1 -c "CREATE USER postgres WITH PASSWORD 'postgres';"
sudo sudo -u postgres psql -1 -c "ALTER USER postgres WITH SUPERUSER;"

# MySQL
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get -y install mysql-server libmysqlclient-dev

# Memcached
sudo apt-get install -y memcached

# Redisпше
sudo apt-get install -y redis-server


# setup rbenv and ruby-build
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# Install ruby 2.2.0 and bundler
export RBENV_ROOT="${HOME}/.rbenv"
export PATH="${RBENV_ROOT}/bin:${PATH}"
export PATH="${RBENV_ROOT}/shims:${PATH}"
rbenv install 2.2.0
rbenv global 2.2.0
gem install bundler
rbenv rehash

# cleanup
sudo apt-get clean
