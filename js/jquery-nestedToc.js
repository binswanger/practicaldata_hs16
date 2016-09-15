(function($) {

  /*
   jQuery nestedToc Plugin 0.3
   https://github.com/dncrht/nestedToc

   Copyright (c) 2014 Daniel Cruz Horts

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
   THE SOFTWARE.
   */

  function Toconize(settings) {
    this.settings = settings;
  }

  Toconize.prototype = {

    call: function() {
      var tree = this._sequentialAnalysis();
      return this._buildList('root', tree);
    },

    // Analyses the document sequentially, mapping the heading sizes
    // into a hierarchical tree
    _sequentialAnalysis: function() {
      var headingsNameHistory = ['root']; // heading names, to avoid naming collision when creating unique ids
      var tree = {root: []} // initialises the 'tree': a list of nodes and its subnodes
      var parentStack = ['root']; // a stack of parent nodes, to know which parent stores which child
      previous_heading_level = -1;
      $(this.settings.container).find('h1, h2, h3, h4, h5, h6').each(function(index, element) {

        var id = $(element).html().replace(/[^\w]/g, '-');

        if (headingsNameHistory.indexOf(id) != -1) { // dupe heading name
          var rand = parseInt(Math.random() * 100);
          id += '-' + rand; // let's make it unique by adding a random number
        }
        headingsNameHistory.push(id); // keep track to guarantee uniqueness
        $(this).attr('id', id); // persist unique identifier back to the tag

        current_heading_level = parseInt($(element).get(0).tagName.replace(/[^\d]+/, ''));
        if (previous_heading_level == -1) { // automatically determine previous level on first loop
          previous_heading_level = current_heading_level - 1;
        }

        tree[id] = []; // initialize new potential parent node
        if (current_heading_level > previous_heading_level) {
          if ((current_heading_level - previous_heading_level) > 1) {
            throw id;
          }
          tree[parentStack[0]].push(id); // add node to parent
          parentStack.unshift(id);
        } else if (current_heading_level < previous_heading_level) {
          for (var i = 0; i < (previous_heading_level - current_heading_level); i++) {
            parentStack.shift();
          }
          tree[parentStack[1]].push(id); // add node to sibling
          parentStack[0] = id;
        } else { // previous_heading_level == current_heading_level
          tree[parentStack[1]].push(id); // add node to sibling
          parentStack[0] = id; // consider this as the new parent
        }

        previous_heading_level = current_heading_level;
      });

      return tree;
    },

    // Builds a nested structure of ordered lists, recursively
    _buildList: function(branch, tree) {
      var output = '';
      if (tree[branch].length > 0) {
        output += "<ol>\n";
        for (key in tree[branch]) {
          var element = tree[branch][key];
          output += '<li><a href="#' + element + '">' + $('#' + element).html() + '</a>' + this._buildList(element, tree) + "</li>\n";
        }
        output += '</ol>';
      }
      return output;
    },
  }

  $.fn.nestedToc = function(options) {
    var settings = $.extend({
      container: 'body'
    }, options);

    var toconize = new Toconize(settings);

    try {
      var content = toconize.call();
    } catch (id) {
      var content = 'FATAL ERROR: non-linear levels at ' + id
    }

    this.html(content);

    return this;
  };

}(jQuery));
