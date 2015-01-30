gulp = require "gulp"
_ = require "lodash"
runSequence = require "run-sequence"
requireDir = require "require-dir"

config =
  paths:
    dest: 'build/'

    assets: 'src/assets/'
    scriptsIn: 'src/coffee/'
    stylesIn: 'src/scss/'
    testsIn: 'specs/'
    vendorIn: 'src/vendor/'

    scriptsOut: 'build/js/'
    stylesOut: 'build/css/'

# Load all tasks
tasks = requireDir "tasks/"

# Get environment, for environment-specific activities
env = process.env.BUILD_ENV or "development"

# Loop through all tasks and create them
_.each tasks, (task) ->
  task(gulp, config, env)

# The "default" and "build" tasks will be your most commonly-used tasks from
# the CLI.  The more granular tasks are in "tasks/"

gulp.task "build", (callback) ->
  # runSequence is a gulp plugin that is a little bit of a hack.  It lets us
  # define synchronous tasks without requiring that task to be a dependency.
  # To add more async tasks, add them to the array.
  runSequence(
    'clean'
    'assets'
    'grunticon'
    [
      'scripts'
      'styles'
      'templates'
    ]
    callback
  )

gulp.task "default", (callback) ->
  runSequence('watch', 'build', 'server', callback)

gulp.task "ci", (callback) ->
  runSequence('build', callback)
