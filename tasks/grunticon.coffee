shell = require("gulp-shell")

module.exports = (gulp, cfg, env) ->

  gulp.task('grunticon', shell.task([
    'node_modules/.bin/grunt grunticon'
  ]))

