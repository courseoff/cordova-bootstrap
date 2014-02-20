# where we can find local binaries installed with "npm install"
nodebin = node_modules/.bin
ripple = $(nodebin)/ripple
cordova = $(nodebin)/cordova

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
	$(ripple) emulate

# absolute clean, basically returns repo to checkout state
clean:
	rm -rf platforms plugins merges

.PHONY: build-prod clean install-deps

