# Cordova Browserify Bootstrap

Example cordova application showing how to work with js modules, multiple css files, and builds to create a maintainable application with html/js/css technologies.

What's more, this example app integrates [Browserify](http://browserify.org), [Coffeescript](http://coffeescript.org), [Less](http::/lesscss.org)

## Project organization

package.json
  - dependencies and development tools

Makefile
  - use `make init` to initialize folders
  - quick commands to ease development and release

/src
  - development files, including `coffee/`, `less/`
  - `coffee/`: Coffeescript files/modules, built into final bundle with browserify
  - `less/`: Less files, built using less

/www
  - assets seen by cordova webview
  - avoid putting *active* assets here (js, css, etc). Ok to put static assets like fonts, images, etc.

/tools
  - scripts to aid in testflight and appstore release

## Development workflow

For rapid testing in a local browser during development, use the following commands to streamline asset building and testing.

* execute following shell commands:
  ```
  $ grunt devwatch # Recompile all assets and watch it
  $ grunt serve # Start ripple. Check it on http://localhost:1337/
  ```
* Develop code in `src/` folder, files would be recompiled as soon as saved.
* Refresh tab by clicking `Enter`. Do not use F5/Cmd+R!

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
