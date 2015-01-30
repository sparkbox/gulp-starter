(function() {
  module.exports.register = function(Handlebars, options, params) {

    /**
     * Helper name
     * @param  {[type]} str [description]
     * @return {[type]}     [description]
     */
    Handlebars.registerHelper('class', function(str) {
      var count = 0;
      var out = 'class="';
      var classSplit, prop, className;
      var classes = str.split(' ');
      var mustacheRegex = /{{([^}]+)}}/;

      classes.forEach(function(){
        classSplit = classes[count].split(':');
        prop = classSplit[0];
        className = classSplit[1];

        // check if classname has mustache tag in it
        if (typeof className !== 'undefined' && className.match(mustacheRegex)) {
          var dynamicProp = className.match(mustacheRegex)[1];
          className = className.replace(mustacheRegex, this[dynamicProp]);
        }

        if (prop === '' || !!this[prop]) {
          if (count > 0) {
            // add preceding space
            out = out + ' ';
          }
          out = out + (className || prop);
        }
        count++
      }, this);

      out = out + '"';

      return new Handlebars.SafeString(out);
    });

  };
}).call(this);
