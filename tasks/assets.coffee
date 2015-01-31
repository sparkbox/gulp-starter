module.exports = (gulp, cfg, env) ->

  gulp.task 'moveAssets', ->
    gulp.src(cfg.paths.assets + "**/*")
    .pipe(gulp.dest(cfg.paths.dest))

  gulp.task 'assets', ['moveAssets']
