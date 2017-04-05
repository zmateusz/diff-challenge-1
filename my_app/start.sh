#!/bin/bash

gem install bundler --conservative
bundle check || bundle install

bin/rails db:setup
bin/rails log:clear tmp:clear

bin/rails server
