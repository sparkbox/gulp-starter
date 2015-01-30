module.exports = (gulp, cfg, env) ->
  del = require 'del'

  gulp.task 'clean', (cb) ->
    del cfg.paths.dest, cb
