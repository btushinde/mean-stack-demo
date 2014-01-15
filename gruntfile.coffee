module.exports = (grunt) ->
  # Grab all grunt-* packages from package.json and load their tasks
  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  # Project Configuration
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    watch:
      jade:
        files: ['views/**/*.jade']
        tasks: ['jade']
        options:
          livereload: true

      coffee:
        files: 'assets/js/**/*.coffee'
        tasks: ['coffeelint:app', 'coffee']
        options:
          livereload: true

      coffee_server:
        files: 'app/**/*.coffee'
        tasks: ['coffeelint:server']

      stylus:
        files: 'assets/css/**/*.styl'
        tasks: ['stylus']
        options:
          livereload: true


    # Compile Jade templates
    jade:
      options:
        pretty: true
      compile:
        files:[
          expand: true
          cwd: 'views',
          src:  '**/*.jade'
          dest: 'public/views'
          ext:  '.html'
        ]

    # Compile Stylus to CSS
    stylus:
      compile:
        options:
          linenos: true
          compress: false
        files: [
          expand: true
          cwd: 'assets/css'
          src:  '**/*.styl'
          dest: 'public/css'
          ext:  '.css'
        ]

    # Compile CoffeeScript
    coffee:
      compile:
        files: [
          expand: true
          cwd: 'assets/js',
          src:  '**/*.coffee'
          dest: 'public/js'
          ext:  '.js'
        ]


    # CoffeeLint for helpful feedback
    coffeelint:
      app: ['assets/**/*.coffee']
      server: ['app/**/*.coffee']
      gruntfile: 'Gruntfile.coffee'
      options:
        max_line_length:
          value: 160
          level: 'warn'
        no_throwing_strings:
          level: 'warn'


    # Clean up asset files
    clean:
      js:     ['public/js']
      css:    ['public/css']
      views:  ['public/views']
      images: ['public/img']

    # Copy files
    copy:
      images:
        files:[
          expand: true
          cwd: 'assets/img'
          src: '**/*'
          dest: 'public/img'
          filter: 'isFile'
        ]




    # Reload the Node server on code change
    nodemon:
      dev:
        options:
          file: 'server.coffee'
          ignoredFiles: ['README.md', 'node_modules/**', '.DS_Store']
          watchedExtensions: ['coffee']
          watchedFolders: ['app', 'config']
          debug: true
          delayTime: 1
          env:
            PORT: 3000
          cwd: __dirname


    # Run Mocha tests
    mochaTest:
      options:
        reporter: 'spec'
      src: ['test/**/*.js']

    env:
      test:
        NODE_ENV: 'test'



  # DEFINE TASKS

     # Multi-core tasking!
    concurrent:
      tasks: ['nodemon', 'watch']
      options:
        logConcurrentOutput: true


  # Default task(s).
  grunt.registerTask 'default',   ['build', 'coffeelint:server', 'concurrent']
  grunt.registerTask 'build',     ['clean', 'coffeelint:app', 'coffee', 'jade', 'stylus', 'copy']

  # Test task.
  grunt.registerTask 'test',      ['env:test', 'mochaTest']