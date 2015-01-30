module.exports = (gulp, cfg, env) ->

  gulp.task 'watch', ->
    gulp.watch(cfg.paths.assets + '**/*', ['build'])
    gulp.watch([cfg.paths.scriptsIn + '**/*.coffee', cfg.paths.scriptsIn + '**/*.js'], ['scripts'])
    gulp.watch(cfg.paths.stylesIn + '**/*.scss', ['styles'])
    gulp.watch(['src/partials/**/*.hbs', 'src/templates/**/*.hbs', 'src/patterns/**/*.hbs', 'lib/helpers/**/*', 'src/data/**/*.json', 'src/data/**/*.yml'], ['templates'])


    # This doesn't seem to be picking up on bower installs.
    gulp.watch(cfg.paths.vendorIn + '**/*.js', ['vendor'])
