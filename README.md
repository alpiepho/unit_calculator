# unit_calculator

A Flutter PWA that shown Unit conversions like Inches vs Centimeters

**TODO**
- refactor select page as about/settings page
- add darkmode setting
- persist settings
- add more conversions
  - ft yards
  - yards ft
  - ft meter
  - meter ft
  - cooking
- make sure carry over values work as expected (cooking?)
- publish as pwa to gh-pages
- finish pwa manual tweaks for base pwa
- finish pwa manual tweaks for best Lighthouse score

- finish this README



**NOTES FROM flutter create web**

In order to run your application, type:

  $ cd web
  $ flutter run

To enable null safety, type:

  $ cd web
  $ dart migrate --apply-changes


## Issues with GitHub Pages and Flutter app as PWA

- need to add full gh-pages url to index.html `<base href="/">`
- used peanut to build and push to gh-pages branch
- **HACK** Flutter has poor support here, to get PWA add gh-pages url to all links in gh-pages branch mainfest.json
- see end of https://github.com/flutter/flutter/issues/60069, issue 10-14 days old



## (Original) Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
