#!/bin/bash
if [ ! -e /usr/bin/chef-client ]; then
  curl -L https://www.opscode.com/chef/install.sh | bash
fi

