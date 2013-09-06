'use strict'

path = require 'path'

lrSnippet = require('grunt-contrib-livereload/lib/utils').livereloadSnippet

folderMount = (connect, point) ->
  return connect.static path.resolve point

module.exports = (grunt) ->
  pkg = undefined

  readJSON = (path, isPkg = false) ->
    path = if isPkg then path else "#{pkg.config.dir}/#{path}"
    json = grunt.file.readJSON __dirname + '/' + path + ".json"
    return if isPkg then pkg = json else json

  # Project configuration.
  grunt.initConfig
    pkg: readJSON('package', true)
    coffee: readJSON "coffee"
    stylus: readJSON "stylus"
    jade: readJSON "jade"
    watch: readJSON "watch"
    livereload: readJSON 'livereload'

    connect:
      options:
        port: '<%= pkg.config.connect.port %>'
        middleware: (connect, options)->
          return [lsSnippet, folderMound connect, options.base]

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
