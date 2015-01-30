/**
 * This helper returns a JSON string based on a string representation of
 * a data file. So, if you have a data file called 'myData' it is stored in the
 * top context as an object key. This helper returns the JSON string version of 
 * that file.
 *
 * Specific use case where the data file needs to be printed for debugging or
 * to be stored in a variable in JS or other access.
 *
*/
'use strict';

module.exports.register = function(Handlebars) {
  Handlebars.registerHelper('printDataJSON', function(data) {
    return JSON.stringify(this[data]);
  });
};
