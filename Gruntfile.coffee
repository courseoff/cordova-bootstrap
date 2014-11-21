# TODO: 
# watch ripple
# add livereload.js in index.html

module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-browserify"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-cssmin"
  grunt.loadNpmTasks "grunt-contrib-less"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-exec"

  grunt.initConfig
    connect:
      options:
        port: 1337
        base: "."
        livereload: 35729
        hostname: grunt.option('hostname') || '0.0.0.0'
        open: true

    clean: ['www/index.js', 'www/index.min.js', 'www/index.css']

    exec:
      ripple:
        cmd: "make ripple-emulate"
      cordova_build:
        cmd: 'make build-prod'
      cordova_build_android:
        cmd: 'make build-prod-android'
      cordova_build_ios:
        cmd: 'make build-prod-ios'
      cordova_platforms:
        cmd: 'make platforms'
      cordova_platforms_android:
        cmd: 'make platforms/android'
      cordova_platforms_ios:
        cmd: 'make platforms/ios'

    less:
      default:
        files:
          "www/index.css": ["src/less/index.less"]

    browserify:
      default:
        files:
          "www/index.js": ["src/coffee/index.coffee"]
        options:
          transform: ['browserify-file', 'coffeeify']
          ext: ".js"

    uglify:
      default:
        files:
          'www/index.min.js': ['www/index.js']

    ripple:
      options:
        open: true
        keepAlive: true
        path: '/www'

    watch:
      options:
        livereload: true 
      gruntfile:
        files: ["Gruntfile.js"]
        options:
          reload: true
      js:
        files: "src/coffee/*.coffee"
        tasks: ["browserify"]
        options:
          livereload: true
      css:
        files: "src/less/*.less"
        tasks: ["less"]
        options:
          livereload: true
      html:
        files: ["www/index.html", "src/**/*.html"]
        options:
          livereload: true
      
  grunt.registerTask "compile", ->
    grunt.task.run [
      "browserify",
      "uglify",
      "less"
    ]

  # start a server and connect it via ripple
  # watch files and reload page if file changes
  grunt.registerTask "serve", -> 
    grunt.task.run [
      "connect",
      "clean",
      "compile",
      "watch",
      #"exec:ripple"
    ]

  # pass
  grunt.registerTask "build", ->
    grunt.task.run [
      "clean",
      "compile",
      "exec:cordova_build"
    ]
