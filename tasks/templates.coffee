module.exports = (gulp, cfg, env) ->
  gulp = require 'gulp'
  _ = require "lodash"
  requireDir = require "require-dir"
  assemble = require 'assemble'
  flatten = require 'gulp-flatten'
  Handlebars = require 'assemble/node_modules/handlebars'
  handlebarsHelpers = require 'handlebars-helpers'
  helpers = requireDir "../lib/helpers/"

  templateDir = 'src/templates/'
  options =
    pages: templateDir + 'pages/**/*.hbs'
    layouts: templateDir + 'layouts/**/*.hbs'
    partials: 'src/partials/**/*.hbs'
    patternDir: 'src/patterns/'
    patternsOut: cfg.paths.dest + 'patterns/'

  params =
    grunt: {}
    assemble: assemble

  pages = [
    'src/patterns/{pages,templates}/**/*.hbs'
  ]

  patterns = [
    options.patternDir + '**/*.hbs'
    '!' + pages
  ]

  # register handlebars-helpers package
  handlebarsHelpers.register(Handlebars, options, params)

  # Without this, streams will pollute each other
  # Not quite sure why. Leave this alone unless you understand the
  # consequences.
  assemble.disable 'buffer plugin'

  setupAssemble = ->
    # register our custom handlebars helpers
    _.each helpers, (helper)->
      helper.register(Handlebars, options)

    assemble.namespace(':basename', ['src/data/**/*.json', 'src/data/**/*.yml'])
    assemble.layouts([options.layouts])
    assemble.partials([options.partials])

  gulp.task 'patterns', ->
    setupAssemble()
    assemble.src(patterns, layout: 'pattern')
      .pipe(assemble.dest(options.patternsOut))

  gulp.task 'pages', ->
    setupAssemble()
    assemble.src(pages, layout: 'page')
      .pipe(assemble.dest(options.patternsOut))

  gulp.task 'templates', ['patterns', 'pages']
