#!/bin/sh
composer config --global repositories.artestead vcs https://github.com/OlivierParent/artestead.git
composer global require olivierparent/artestead
artestead init --skip --vagrant-plugin-install