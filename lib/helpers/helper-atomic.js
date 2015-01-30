/**
 * Handlebars Helpers for Pattern Lab
 * Copyright (c) 2014 Jon Schlinkert
 * Licensed under the MIT License (MIT).
 */
'use strict';

var path = require('path');
var fs = require('fs');
var util = require('util');
var file = require('fs-utils');
var _ = require('lodash');
var jsyaml = require('js-yaml');
var fm = require('front-matter');

var templateCache = [];

module.exports.register = function (Handlebars, options, params) {
  options = options || {};
  var config = _.extend(options, options.data || {});

  function getDirectories(rootDir) {
    return fs.readdirSync(rootDir).filter(function (file) {
      return fs.statSync(rootDir + file).isDirectory();
    });
  }

  var patterns = getDirectories('src/patterns/');

  patterns.forEach(function(pattern) {
    file.expand(options.patternDir + pattern + '/**/*.hbs').map(function(filepath) {
      var dir = file.dirname(filepath);
      var cleanName = file.base(filepath).replace(/\d+-/, '').replace(/^_/, '');

      var name = pattern + '-' + cleanName;

      var template = file.readFileSync(filepath);
      Handlebars.registerPartial(name, template);
    });

    Handlebars.registerHelper(pattern, function() {
      var self = this,
          name,
          context = {},
          options = {},
          data = {},
          templateName,
          template,
          yfm,
          fn;

      // name is required
      // context is optional
      // options is always passed last, even if it's not passed
      if (arguments.length === 2) {
        name = _.clone(arguments[0]);
        options = _.clone(arguments[1]);
      } else {
        name = _.clone(arguments[0]);
        context = _.clone(arguments[1]);
        options = _.clone(arguments[2]);
      }

      templateName = Handlebars.partials[pattern + '-' + name];

      // extract yaml front matter from template
      yfm = fm(templateName);
      template = yfm.body;

      // mix all available data together.
      // order of these is lowest priority to highest
      data = _.extend({}, yfm.attributes, self, context, options.hash);

      if (typeof options.fn !== 'undefined') {
        // helper is called as a block,
        // so lets compile the contents of the block,
        // and set it as data's outlet property
        data.outlet = options.fn(data);
      }

      if (pattern == 'organism') {
        var template = "\n<!---start " + pattern + ": " + name + "--->\n\n" + template + "\n<!---end " + pattern + ": " + name + "--->";
      }

      if (!templateCache[template]) {
        templateCache[template] = Handlebars.compile(template);
      }
      fn = templateCache[template];

      return new Handlebars.SafeString(fn(data));
    });
  });

  function prettify(str) {
    var numbersAndExtension = /^\d*-(.*?)|\.hbs/g;

    // remove numbers and extension,
    str = str.replace(numbersAndExtension, '');

    // hyphens to spaces,
    str = str.replace(/-/g, ' ');

    // title case
    str = str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});

    str = str.split('_')[0];

    return str;
  }

  function getPatterns(dir) {
    var allPatterns = file.expand(dir + '/**/*.hbs');

    var patterns = [];

    _.each(allPatterns, function(fullFilepath){
      // remove directory
      var filepath = fullFilepath.replace(dir + '/', '');

      var splitPath = filepath.split('/');

      // If you aren't me, I'm sorry about this.
      if (splitPath.length === 3){
      // nested in groups

        var type = splitPath[0],
            group = splitPath[1],
            patternName = splitPath[2];

        var prettyType = prettify(type),
            prettyGroup = prettify(group),
            prettyName = prettify(patternName),
            modifiers;

        if (patternName[0] === '_') {
          return;
        }

        if (patternName.split('_').length > 1) {
          modifiers = patternName.split('_');

          // Remove the first item, which is the actual name
          modifiers.shift();

          // Remove extension
          var last = modifiers.length - 1;
          modifiers[last] = modifiers[last].replace('.hbs', '');
        }

        var destPath = fullFilepath.replace('src', '').replace(/hbs$/, 'html');

        var pattern = {
          'name': patternName,
          'prettyName': prettyName,
          'path': destPath,
        };

        if (modifiers) {
          pattern.modifiers = modifiers;
        }

        if (_.find(patterns, { 'name': type }) === undefined) {
          // create type
          patterns.push({ 'name': type, 'prettyName': prettyType, 'children': [] });
        }

        var types = _.find(patterns, { 'name': type }).children;

        if (_.find(types, { 'name': group }) === undefined) {
          // create group
          types.push({ 'name': group, 'prettyName': prettyGroup, 'children': [] });
        }

        var patternItems = _.find(types, { 'name': group }).children;

        // lowest level
        patternItems.push(pattern);

      } else {
      // not nested in groups

        var type = splitPath[0],
            patternName = splitPath[1]
            modifiers;

        if (patternName[0] === '_') {
          return;
        }

        if (patternName.split('_').length > 1) {
          modifiers = patternName.split('_');

          // Remove the first item, which is the actual name
          modifiers.shift();

          // Remove extension
          var last = modifiers.length - 1;
          modifiers[last] = modifiers[last].replace('.hbs', '');
        }

        if (patternName.match(/index/)) {
          // prevent index page from being listed
          return;
        }

        var prettyType = prettify(type),
            prettyName = prettify(patternName);

        var destPath = fullFilepath.replace('src', '').replace(/hbs$/, 'html');

        var pattern = {
          'name': patternName,
          'prettyName': prettyName,
          'path': destPath
        };

        if (modifiers) {
          pattern.modifiers = modifiers;
        }

        if (_.find(patterns, { 'name': type }) === undefined) {
          // create type
          patterns.push({ 'name': type, 'prettyName': prettyType, 'children': [] });
        }

        var types = _.find(patterns, { 'name': type }).children;

        // lowest level
        types.push(pattern);

      }
    });
    return patterns;
  }

  Handlebars.registerHelper('patternJSON', function() {
    return JSON.stringify(getPatterns('src/patterns'));
  });

};
