module.exports = (gulp, cfg, env) ->
  concat = require "gulp-concat"
  uglify = require "gulp-uglify"
  order = require "gulp-order"
  sourcemaps = require "gulp-sourcemaps"
  coffee = require "gulp-coffee"
  mainBowerFiles = require "main-bower-files"
  merge = require 'merge-stream'
  gulpif = require "gulp-if"
  errorHandler = require '../lib/error-handler'
  plumber = require 'gulp-plumber'

  gulp.task 'moveModernizr', ->
    return gulp.src("bower_components/modernizr/modernizr.js")
    .pipe gulp.dest(cfg.paths.scriptsOut + 'libs/')

  gulp.task "scripts", ['moveModernizr'], ->
    bowerFiles = gulp.src(mainBowerFiles(
      env: env
    ), base: 'bower_components')

    otherJS = gulp.src([
      cfg.paths.vendorIn + '**/*.js'
    ])

    coffeeJS = gulp.src("src/coffee/*.coffee")
      .pipe(coffee(bare: true))
      .pipe gulp.dest(cfg.paths.scriptsOut)

    merge(bowerFiles, coffeeJS, otherJS)
      .pipe order([
        "bower_components/jquery/**/*.js"
        "bower_components/**/*.js"
        cfg.paths.vendorIn + '**/*.js'
        "src/coffee/*.js"
      ], base: './')
      .pipe gulpif((env is 'development'), sourcemaps.init())
      .pipe plumber(errorHandler: errorHandler.error)
      .pipe concat("app.js")
      .pipe gulpif((env is 'production'), uglify())
      .pipe gulpif((env is 'development'), sourcemaps.write())
      .pipe gulp.dest(cfg.paths.scriptsOut)

  gulp.task "wpScripts", ['moveModernizr'], ->
    coffeeJS = gulp.src("src/coffee/*.coffee")
      .pipe(coffee(bare: true))
      .pipe gulp.dest(cfg.paths.scriptsOut)
