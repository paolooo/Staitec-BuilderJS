module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    path:
      source: 'app/assets'
      publish: 'public'

    jade:
      options:
        pretty: true
      source:
        expand: true
        cwd: '<%= path.source %>/jade'
        src: '**/!(_)*.jade'
        dest: 'public'
        ext: '.html'

    coffee:
      glob_to_multiple:
        expand: true
        flatten: true
        cwd: '<%= path.source %>/coffee'
        src: ['**/*.coffee']
        dest: '<%= path.publish %>/js'
        ext: '.js'

    watch:
      jade:
        files: '**/*.jade'
        tasks: ['jade']
      coffee:
        files: '**/*.coffee'
        tasks: ['coffee']

  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  
  grunt.registerTask 'default', ['watch']
