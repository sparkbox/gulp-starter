window.patternLister = {

  list: window.patternList,

  printList: function(){
    var output = '';

    function recurse(node, recursionDepth){
      var recursionDepth = recursionDepth || 1;

      output = output + '<li class="sp_sm">';
      if (node.children) {
        output = output + node.prettyName;
        output = output + '<ul class="sp_top_sm">';
        $.each(node.children, function(i, child){
          recurse(child, recursionDepth + 1);
        });

        output = output + '</ul>';
      } else {
        // final node
        // output = output + '<li>';
        output = output + '<a href="' + node.path + '" title="' + node.name + '" class="link_default">';
        output = output + node.prettyName;
        output = output + '</a>';
        if (node.modifiers) {
          output = output + ' (' + node.modifiers.join(', ') + ')';
        }
        // output = output + '</li>';
      }
      output = output + '</li>';
    }

    $.each(patternList, $.proxy(function(i, type){
      output = output + '<div class="g-1-1 g-md-1-3 sp_xl"><div class="g-inner">';

      output = output + '<div class="tx_bold tx_lg">';
      output = output + type.prettyName;
      output = output + '</div>';

      output = output + '<div class="sp">';
      output = output + '<ul>';
      $.each(type.children, function(i, child){
        recurse(child, 2);
      });
      output = output + '</ul>';
      output = output + '</div>';

      output = output + '</div></div>';
    }, this));

    return output;
    
  },

  createList: function(){
    if (window.patternList) {
      var groupOrder = {
        'atoms': 0,
        'molecules': 1,
        'organisms': 2,
        'templates': 3,
        'pages': 4,
        'systems': 99
      };

      window.patternList.sort(function(a,b){
        return groupOrder[a.name] - groupOrder[b.name];
      });

      $('.js-pattern-list').append(this.printList());
    }
  },

  init: function(){
    this.createList();
  }
};

window.patternLister.init();
