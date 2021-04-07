# unit_calculator

A Flutter PWA that shows Unit conversions like Inches vs Centimeters.

GH-Pages site: https://alpiepho.github.io/unit_calculator/

**TODO**
- validate calc and ranges
- test with others

**Future**
- carry over values from one unit to another
- home-screen icon (seems to be snapshot of app, not icon from manifest.json)
- add dark-mode setting and persist
- force portrait mode (may be Flutter bug)
- improve Lighthouse score (limited by Flutter web at this point)
- re-visit style


## How to Use

There are 5 sections on the main page.  The top row consists of a reference value that can be changed with the middle slider
and -/+ buttons.  The second/right section on the top row is the unit conversion.

To change the reference, use the slider.  Or for 'snap' increment/decrement use the +/- buttons.

The last row will allow scaling the reference value.

Also, you can tap on either section in the top row to bring up a dialog to change the current units.



## Issues with GitHub Pages and Flutter app as PWA

- need to add full gh-pages url to index.html `<base href="/">`
- used peanut to build and push to gh-pages branch
- **HACK** Flutter has poor support here, to get PWA add gh-pages url to all links in gh-pages branch mainfest.json
- see end of https://github.com/flutter/flutter/issues/60069, issue 10-14 days old

## Running peanut

[peanut](https://pub.dev/packages/peanut) is a Dart package to automate the building Flutter and deploying to GitHub Pages.
The following are the rough steps:
```
flutter pub global activate peanut
export PATH="$PATH":"$HOME/development/flutter/.pub-cache/bin"
flutter pub global run peanut
git push origin --set-upstream gh-pages
```

One short-coming of peanut is ith does not handle the relative links in GitHub pages (described above).  To work around this,
there is a script ```run_peanut.sh``` that does those steps.  **NOTE** the path for this repo is hard coded in that script.


## Reference: flutter create web
In order to run your application, type:

  $ cd web
  $ flutter run

To enable null safety, type:

  $ cd web
  $ dart migrate --apply-changes


## Reference: Adding PWA icons

https://stackoverflow.com/questions/56745525/how-to-configure-icon-for-my-flutter-web-application

## Reference: Details of persistent storage
Most common:<br>
https://pub.dev/packages/shared_preferences

This is simpler:<br>
https://pusher.com/tutorials/local-data-flutter

## Reference: Ideas for Units to add

https://www.unitconverters.net/

https://www.isa.org/getmedia/192f7bda-c77c-480a-8925-1a39787ed098/CCST-Conversions-document.pdf


## Reference: (Original) Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
