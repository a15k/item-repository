#!/bin/bash

ruby_version=`cat .ruby-version`
echo Installing Ruby $ruby_version
source /home/ubuntu/rbenv-init && rbenv install -s $ruby_version

echo Installing bundler
gem install --conservative bundler

echo Installing gems
bundle install

echo Done!
