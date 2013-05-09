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

    watch:
      jade:
        files: "**/*.jade"
        tasks: ['jade']

  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  

  grunt.registerTask 'default', ['watch']
