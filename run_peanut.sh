#!/usr/bin/env bash

flutter pub global activate peanut
export PATH="$PATH":"$HOME/development/flutter/.pub-cache/bin"
flutter pub global run peanut

git stash
git checkout gh-pages

sed -e 's/href="\/"/href="https:\/\/alpiepho.github.io\/unit_calculator\/"/' index.html > index.html

sed -e 's/"\/",/"https:\/\/alpiepho.github.io\/unit_calculator\/",/' flutter_service_worker.js > flutter_service_worker.js

sed -e 's/"main.dart.js"/"https:\/\/alpiepho.github.io\/unit_calculator\/main.dart.js"/' flutter_service_worker.js > flutter_service_worker.js
sed -e 's/"index.html"/"https:\/\/alpiepho.github.io\/unit_calculator\/index.html"/' flutter_service_worker.js > flutter_service_worker.js
sed -e 's/"NOTICES"/"https:\/\/alpiepho.github.io\/unit_calculator\/NOTICES"/' flutter_service_worker.js > flutter_service_worker.js
sed -e 's/"AssetManifest.json"/"https:\/\/alpiepho.github.io\/unit_calculator\/AssetManifest.json"/' flutter_service_worker.js > flutter_service_worker.js
sed -e 's/"FontManifest.json"/"https:\/\/alpiepho.github.io\/unit_calculator\/FontManifest.json"/' flutter_service_worker.js > flutter_service_worker.js


git add index.html flutter_service_worker.js
git commit -m "update paths"
git push

git checkout master
git stash pop


