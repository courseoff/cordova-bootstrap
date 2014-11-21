# where we can find local binaries installed with "npm install"
nodebin = node_modules/.bin
ripple = $(nodebin)/ripple
cordova = $(nodebin)/cordova
nodemon = $(nodebin)/nodemon
uglify = $(nodebin)/uglifyjs

# default makefile action is to do nothing
all:

init: plugins platforms

plugins:
	mkdir plugins

platforms: install-deps platforms/ios platforms/android

install-deps:
	npm install

platforms/ios:
	mkdir -p platforms
	$(cordova) platform add ios

platforms/android:
	mkdir -p platforms
	$(cordova) platform add android

build-prod: build-prod-ios build-prod-android

build-prod-ios: assets platforms/ios
	$(cordova) build ios --release

build-prod-android: assets platforms/android
	$(cordova) build android --release

ripple-emulate:
	$(ripple) emulate --port 1337

assets: www/index.css www/index.js

# build single js file starting from index.coffee
www/index.js: $(shell find src/coffee -type f)
	# $@ is an alias for the `target` or www/index.js in this case
	# this will build output file to www/index.js
	$(nodebin)/browserify -t browserify-file -t coffeeify --debug src/coffee/index.coffee | $(uglify) > $@

# build css resource from less assets
www/index.css: $(shell find src/less -type f)
	$(nodebin)/lessc -x src/less/index.less > $@

# clean assets
clean-assets:
	rm -rf www/index.js www/index.css

# this is a helper target during developmnt to rebuild any assets
# nodemon just runs a command when any of the files change
# we run `make assets` when js, styl, or html files change
# in the js or css folders
devwatch:
	$(nodemon) -w src/coffee -w src/less -e js,coffee,css,less,html --exec "make assets"

# absolute clean, basically returns repo to checkout state
clean:
	rm -rf platforms plugins merges

.PHONY: build-prod clean install-deps assets devwatch

