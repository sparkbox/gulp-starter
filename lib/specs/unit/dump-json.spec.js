'use strict';

var dump = require('../../helpers/helper-dump-json'),
    Handlebars = require('assemble/node_modules/handlebars');

dump.register(Handlebars, {});

describe('JSON dump handlebars test', function() {
  var html, data;

  beforeEach(function() {
    data = {product: "test information"};
    html = "{{#dumpJSON product}}{{/dumpJSON}}";
  });

  it('will return valid JSON when given valid JSON', function() {
    var template = Handlebars.compile(html);
    var result = template(data);
    expect(result).toEqual(JSON.stringify(data.product));
  });
});
