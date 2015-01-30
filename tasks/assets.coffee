shell = require("gulp-shell")

module.exports = (gulp, cfg, env) ->

  gulp.task 'moveAssets', ->
    gulp.src(cfg.paths.assets + "**/*")
    .pipe(gulp.dest(cfg.paths.dest))

  gulp.task('grunticon', shell.task([
    'node_modules/.bin/grunt grunticon'
  ]))

  gulp.task 'assets', ['moveAssets']
