#!/bin/bash
#
# modified from the original to allow for different theme directories.
#

cd "$(dirname $0)"

theme_source_dir=${PWD##*/}

which npm > /dev/null
if [ $? -ne 0 ]; then
  echo "ERROR: npm not installed"
  exit 1
fi

which grunt > /dev/null
if [ $? -ne 0 ]; then
  echo "ERROR: grunt not installed; run 'npm install -g grunt-cli'"
  exit 1
fi

set -e
cd ..
mkdir -p target
cd target
if [ -d bootswatch ]; then
  echo "Updating bootswatch"
  cd bootswatch
  git pull
else
  echo "Cloning bootswatch"
  git clone https://github.com/thomaspark/bootswatch.git
  cd bootswatch
fi

mkdir -p dist/kafdrop
cp ../../"$theme_source_dir"/*.scss dist/kafdrop

echo "Building theme from $theme_source_dir"
npm install
grunt swatch:kafdrop
theme_target_dir=src/main/resources/static/css
cp dist/kafdrop/bootstrap.css ../../$theme_target_dir

echo "Theme installed into $theme_target_dir"

