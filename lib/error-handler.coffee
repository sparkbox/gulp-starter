gutil = require 'gulp-util'

fatalLevel = require('yargs').argv.fatal

ERROR_LEVELS = ['error', 'warning']

ERROR_COLORS =
  warning: gutil.colors.yellow
  error: gutil.colors.red

ERROR_EMOTES =
  warning: [
    '¯\\_(ツ)_/¯'
    '(╯︵╰,)'
    '(ಠ_ಠ)'
  ]
  error: [
    '(╯°□°）╯︵ ┻━┻'
    '┻━┻  ︵ \\(°□°)/ ︵ ┻━┻'
    'ლ (ಠ益ಠ)ლ'
  ]

isFatal = (level) ->
  ERROR_LEVELS.indexOf(level) <= ERROR_LEVELS.indexOf(fatalLevel || 'error')

handleError = (level, error) ->

  emotes = ERROR_EMOTES[level]
  color = ERROR_COLORS[level]

  msg = color(level.toUpperCase()) + ' triggered by ' + gutil.colors.magenta(error.plugin)

  randomEmote = emotes[Math.floor(Math.random()*emotes.length)]

  gutil.beep()
  gutil.log(msg)
  gutil.log(color(randomEmote))
  gutil.log(color(error.message))
  process.exit(1) if isFatal(level)

module.exports =
  error: (error) ->
    handleError.call(this, 'error', error)
    this.emit 'end'

  warning: (error) ->
    handleError.call(this, 'warning', error)
    this.emit 'end'
