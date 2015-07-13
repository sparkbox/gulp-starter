module.exports = (gulp, cfg, env) ->
  jasmine = require "gulp-jasmine-phantom"
  webpagetest = require "webpagetest"
  jscs = require 'gulp-jscs'


  gulp.task "tests-integration", ->
    gulp.src([
      "bower_components/jquery/dist/jquery.js",
      "bower_components/jasmine-jquery/lib/jasmine-jquery.js",
      "specs/integration/lib/*.js",
      "specs/integration/**/*[spec].js"
    ]).pipe jasmine
      integration: true

  gulp.task "tests-unit", ->
    gulp.src([
      "specs/unit/lib/*.js",
      "specs/unit/**/*[spec].js"
    ]).pipe jasmine
      integration: false

  gulp.task 'test-handlebars', ->
    gulp.src('lib/specs/unit/**/*.spec.js')
      .pipe jasmine
        integration: false

  gulp.task 'test-perf', ->
    wpt = new webpagetest('www.webpagetest.org', '')
    parameters =
      disableHTTPHeaders: true
      private: true
      video: true
      location: 'Dulles:Chrome'

    testSpecs =
      runs:
        1:
          firstView:
            SpeedIndex: 1500
      median:
        firstView:
          bytesIn: 1000000
          visualComplete: 4000

    wpt.runTest '', parameters, (err, data) ->
      testID = data.data.testId
      checkStatus = ->
        wpt.getTestStatus testID, (err, data) ->
          console.log "Status for #{testID}: #{data.data.statusText}"
          unless data.data.completeTime
            setTimeout checkStatus, 5000
          else
            wpt.getTestResults testID, specs: testSpecs, (err, data) ->
              process.exit 1 if err > 0

      checkStatus()

  gulp.task 'jsstyle-tests', ->
    gulp.src(['!specs/integration/lib/*.js', 'specs/**/*.js'])
      .pipe(jscs())

  gulp.task "test", ['jsstyle-tests', 'tests-integration', 'tests-unit']
