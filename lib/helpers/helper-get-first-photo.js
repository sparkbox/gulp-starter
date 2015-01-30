'use strict';

var _ = require('lodash');

module.exports.register = function (Handlebars){
  Handlebars.registerHelper('getFirstPhoto', function(size, context){
    var root = context.data.root,
        location,
        splitKeys,
        url;

    if(Array.isArray(root.productStyleColors[0])) {
      location = root.productStyleColors[0][0].productStyleColorImages[0];
    } else {
      location = root.productStyleColors[0].productStyleColorImages[0];
    }

    splitKeys = location.split('.')

    url = root.productImages[splitKeys[0]][splitKeys[1]][size];

    return url;
  });
};
