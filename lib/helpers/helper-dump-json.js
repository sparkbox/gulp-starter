/**
 * Handlebars Helpers for Pattern Lab
 * Copyright (c) 2014 Jon Schlinkert
 * Licensed under the MIT License (MIT).
 */
'use strict';

var path = require('path');

module.exports.register = function (Handlebars, options, params) {

  Handlebars.registerHelper('dumpJSON', function(context) {
    var dumpage = arguments.length > 1 ? context : this;

    return JSON.stringify(dumpage);
  });
};
