module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    jade:
      options:
        pretty: true
      source:
        expand: true
        cwd: 'app/assets/jade'
        src: '**/!(_)*.jade'
        dest: 'public'
        ext: '.html'

  grunt.loadNpmTasks 'grunt-contrib-jade'

  grunt.registerTask 'default', ['jade']

