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

    stylus:
      compile:
        files:
          '<%= path.publish %>/css/global.css': '<%= path.source %>/stylus/global.styl'
          '<%= path.publish %>/css/styles.css': '<%= path.source %>/stylus/styles.styl'

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
  
  grunt.registerTask 'default', ['watch']
