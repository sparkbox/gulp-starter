module.exports = (gulp, cfg, env) ->
  webserver = require 'gulp-webserver'

  gulp.task 'server', ->
    gulp.src('build/')
      .pipe webserver
        livereload: true
        host: '0.0.0.0'
