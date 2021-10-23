#! /bin/bash

UNIVERSAL=$(realpath src/universal)
OVERRIDE=$(realpath src/overrides/client)

TMP="$(mktemp -d)"
WD="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P)/.."

pushd "$TMP"

cp -rfL "$UNIVERSAL" ./
cp -rfL "$OVERRIDE" ./

mkdir -p bin
curl -L -o bin/version.json 'https://fabricmc.net/download/technic?yarn=1.17.1%2Bbuild.63&loader=0.12.2'

zip -9r "$WD/output/client.zip" .

popd

rm -r "$TMP"