module.exports = (gulp, cfg, env) ->
  plumber = require 'gulp-plumber'
  errorHandler = require '../lib/error-handler'
  sass = require 'gulp-sass'
  minifyCSS = require 'gulp-minify-css'
  gulpif = require 'gulp-if'
  postcss = require 'gulp-postcss'
  sourcemaps = require "gulp-sourcemaps"

  gulp.task "styles", ->
    processors = [
      require("autoprefixer-core")
    ]
    stream = gulp.src(cfg.paths.stylesIn + '**/*.scss')
      .pipe plumber errorHandler: errorHandler.error
      .pipe gulpif((env is 'development'), sourcemaps.init())
      .pipe sass()
      .pipe postcss(processors)
      .pipe gulpif((env is 'development'), sourcemaps.write cfg.paths.stylesOut)
      .pipe gulp.dest cfg.paths.stylesOut
