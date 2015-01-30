'use strict';

var _ = require('lodash');

module.exports.register = function (Handlebars){
  Handlebars.registerHelper('addContext', function(givenContext, context){
    var newContext = _.extend({}, context.data.root, givenContext);

    return context.fn(newContext);
  });
};
