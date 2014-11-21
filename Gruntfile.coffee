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
          transform: ['browserify-file', 'coffeeify', 'famousify', 'cssify', 'brfs', 'deamdify']
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
        files: ["Gruntfile.coffee"]
        options:
          reload: true
      js:
        files: ["src/coffee/*.coffee", "src/coffee/**/*.coffee"]
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
      
  grunt.registerTask "compile", "Compile assets", ->
    grunt.task.run [
      "browserify",
      "uglify",
      "less"
    ]

  grunt.registerTask "serve", "Start ripple server", ->
    grunt.task.run [
      "exec:ripple"
    ]

  grunt.registerTask "devwatch", 'Recompile all assets and watch it', ->
    grunt.task.run [
      "clean",
      "compile",
      "watch"
    ]

  grunt.registerTask "build", "Build apps", ->
    grunt.task.run [
      "clean",
      "compile",
      "exec:cordova_build"
    ]
