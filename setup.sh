#!/bin/sh

echo 'yum update...'
yum -y update

echo 'install base packages...'

yum -y install git
sudo yum -y install git wget gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel libffi-devel libxml2 libxslt libxml2-devel libxslt-devel sqlite-devel mysql-devel nginx

echo 'install base package done'
echo 'updating ruby...'

git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv

echo 'export RBENV_ROOT="/usr/local/rbenv"' >> /etc/profile
echo 'export PATH="${RBENV_ROOT}/bin:${PATH}"' >> /etc/profile
echo 'eval "$(rbenv init -)"' >> /etc/profile

source /etc/profile
git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

rbenv install -v 2.5.0
rbenv rehash
rbenv global 2.5.0

gem update --system
gem install bundler

echo 'redis-install'
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
yum -y --enablerepo=remi install redis

echo 'update ruby done.'
echo 'install node.js'

git clone git://github.com/creationix/nvm.git /home/ec2-user/.nvm
echo 'source /home/ec2-user/.nvm/nvm.sh' >> /etc/profile
nvm install v8.9.0

echo 'install node.js done'

echo 'yarn install...'
curl -o- -L https://yarnpkg.com/install.sh | bash
echo 'export PATH="/root/.yarn/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

mkdir /var/www
chown ec2-user /var/www

# 環境変数のセット
echo 'export RAILS_SERVE_STATIC_FILES=1' >> /etc/profile
echo 'export SECRET_KEY_BASE=44c051894da07f1516c89ce7d2bcc8db37f9dade89d88126d072b5fe3246703e336e701cf7b68ca2fceedcee64911015e357dc1c534628bff6295c81d52d73a4' >> /etc/profile
echo 'export RAILS_ENV=production' >> /etc/profile
echo 'export PORT=80' >> /etc/profile

echo 'end!'
