module.exports = (grunt) ->

  grunt.config "grunticon",
    icons:
      files: [
        expand: true,
        cwd: 'src/grunticon/source',
        src: ["*.svg", ".png"],
        dest: 'build/grunticon'
      ]

  grunt.loadNpmTasks 'grunt-grunticon'
