#!/bin/bash

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ruby "$DIR/bin/gitsy.rb" "prod" $@

