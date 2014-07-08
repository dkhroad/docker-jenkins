#!/bin/bash
#set -x
read -d '' PLUGINS <<EOL
https://updates.jenkins-ci.org/latest/git-client.hpi
https://updates.jenkins-ci.org/latest/git.hpi
https://updates.jenkins-ci.org/latest/scm-api.hpi
https://updates.jenkins-ci.org/latest/ansicolor.hpi
https://updates.jenkins-ci.org/latest/swarm.hpi
EOL

PLUGIN_DIR="/var/lib/jenkins/plugins"

su - jenkins -c "mkdir -p $PLUGIN_DIR"
for plugin in  $PLUGINS; do
   echo "installing plugin $(basename $plugin) in dir: $PLUGIN_DIR"
   su - jenkins -c "curl --progress-bar -L  -o $PLUGIN_DIR/$(basename $plugin) $plugin"
   ls -l $PLUGIN_DIR/$(basename $plugin)
done
