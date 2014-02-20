# cordova bootstrap

Example cordova application showing how to work with js modules, multiple css files, and builds to create a maintainable application with html/js/css technologies.

This project was first initialized with the following command and committed into this repo as the first commit.
```
cordova create bootstrap com.example.bootstrap Bootstrap
```

## project organization

package.json
  - dependencies and development tools

Makefile
  - `make init`
  - quick commands to ease development and release

/www
  - assets seen by cordova webview
  - avoid putting *active* assets here (js, css, etc). Ok to put static assets like fonts, images, etc.

/js
  - javascript files/modules
  - built into final bundle with browserify

/css
  - stylesheets, built using stylus

/tools
  - scripts to aid in testflight and appstore release


## development workflow

For rapid testing in a local browser during development, use the following commands to streamline asset building and testing.

```
$ make ripple-emulate
$ make devwatch
```

* `ripple-emulate` runs the `ripple` emulator
* `devwatch` simply watches for changes to certain files and rebuilds assets

### tips

* Typical development workflow is to develop locally with ripple, then test using emulators and finally using actual devices. **ALWAYS** test on actual devices before releasing anything.

### gotchas

* Don't use absolute paths in `src` or `href` or css `urls`. These will not work when deployed to devices or simulators.

## release workflow

**recommend** using a clean clone of the repo

See the `/tools` folder for the `release` scripts which will build a release using command line

### gotcha

These are items which cordova doesn't do by default (yet) when making a release build. Some of them have a work around in the release script.

`debuggable=false` should be set in AndroidManifest.xml (done in release script)

`TARGET_DEVICE_FAMILY = 1` for ios builds only for iphone (in build.xconfig ios platform dir, but not done automatically yet)

