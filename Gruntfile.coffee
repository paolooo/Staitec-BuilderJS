'use strict'

path = require 'path'
lrSnippet = require('grunt-contrib-livereload/lib/utils').livereloadSnippet

folderMount = (connect, point) ->
  return connect.static path.resolve point

module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON __dirname + '/package.json'

    livereload:
      port: '<%= pkg.config.livereload.port %>' # Default livereload listening port.
    connect:
      options:
        port: '<%= pkg.config.connect.port %>'
        middleware: (connect, options)->
          return [lsSnippet, folderMound connect, options.base]

    jade:
      options:
        pretty: true
      source:
        expand: true
        cwd: '<%= pkg.config.path.source %>/jade'
        src: '**/!(_)*.jade'
        dest: '<%= pkg.config.path.dest %>'
        ext: '.html'

    coffee:
      glob_to_multiple:
        expand: true
        flatten: true
        cwd: '<%= pkg.config.path.source %>/coffee'
        src: ['**/*.coffee']
        dest: '<%= pkg.config.path.dest %>/js'
        ext: '.js'

    stylus:
      compile:
        files:
          '<%= pkg.config.path.dest %>/css/global.css': '<%= pkg.config.path.source %>/stylus/global.styl'
          '<%= pkg.config.path.dest %>/css/styles.css': '<%= pkg.config.path.source %>/stylus/styles.styl'

    watch:
      jade:
        files: '**/*.jade'
        tasks: ['jade']
      coffee:
        files: '**/*.coffee'
        tasks: ['coffee']
      stylus:
        files: '**/*.styl'
        tasks: ['stylus']

  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  
  grunt.registerTask 'default', ['livereload-start', 'connect']
  grunt.registerTask 'start:server', ->
    grunt.util.spawn
      cmd: 'coffee'
      args: ['./server.coffee']
      opts:
        stdio: 'inherit'

    grunt.log.writeln 'Started web server on port ', grunt.config.get('pkg').config.server.port

  grunt.registerTask 'start', ['start:server', 'watch']
