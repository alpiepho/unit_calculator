# unit_calculator

A Flutter PWA that shown Unit conversions like Inches vs Centimeters

**TODO**
- version number (variable)
- gh link (as link)
- try add gh-page base url directly to index.hmtl (can we still debug?)
    - (https://alpiepho.github.io/unit_calculator/)
- try gh-page base url directly to flutter_service_worker.js
- force portrait mode
- persist settings
    - unittype
    - valueleft
    - tenx
    - twox
- add darkmode setting and persist
- add -1 +1 to slider card
- conditional style on values to scale down font
- refactor for private variables and methods
- other refactor (includes, repeated code)
- change convert to inline
- add more conversions
  - ft yards
  - yards ft
  - ft meter
  - meter ft
  - cooking
- make sure carry over values work as expected (cooking?)
- improve Lighthouse score
- create icon

- finish this README
- re-visit style
- test with others



**NOTES FROM flutter create web**

In order to run your application, type:

  $ cd web
  $ flutter run

To enable null safety, type:

  $ cd web
  $ dart migrate --apply-changes


## Running peanut

flutter pub global activate peanut
export PATH="$PATH":"$HOME/development/flutter/.pub-cache/bin"
flutter pub global run peanut:peanut
git push origin --set-upstream gh-pages

## Issues with GitHub Pages and Flutter app as PWA

- need to add full gh-pages url to index.html `<base href="/">`
- used peanut to build and push to gh-pages branch
- **HACK** Flutter has poor support here, to get PWA add gh-pages url to all links in gh-pages branch mainfest.json
- see end of https://github.com/flutter/flutter/issues/60069, issue 10-14 days old

## Details of persistent storage
https://pub.dev/packages/shared_preferences


## (Original) Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
