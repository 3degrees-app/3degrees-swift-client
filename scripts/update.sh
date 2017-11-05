#!/bin/sh

if [ -z "$1" ]; then
  echo "Please supply the version number"
  exit 1
fi

cat config.json | jq ".podVersion = \"$1\"" > config.json.tmp
mv config.json.tmp config.json

java \
  -jar swagger-codegen-cli.jar generate \
  -i https://swaggerhub.com/apiproxy/schema/file/3degreesapp/3-degrees/$1/swagger.json \
  -l swift \
  -o /projects/3degrees-swift-client \
  -c config.json

cd ..

git status
