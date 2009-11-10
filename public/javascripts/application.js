//Globals
var messagesPath = '/messages', content, message;

$(document).ready(function() {
  message = $('#message');
  content = $('#content');
  $('*[title]').inputHint();
  $('#breadcrumb a:last').click(function(){
    content.spin().load($(this).attr('href'), function(){
        message.html('');
        content.unspin();
    });
    return false;
  });
});

/** TEMP BEFORE NEXT JQUERY VERSION **/
/*
 * jQuery UI fade effect, based on pulsate
 *
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 * Depends:
 * effects.core.js
 */
(function($) {
$.effects.fade = function(o) {
  return this.queue(function() {
    // Create element
    var el = $(this);

    // Set options
    var speed = o.options.speed || 400;
    var mode = o.options.mode || 'show'; // Set Mode

    // Animate
    if (mode == 'show') {
      el.fadeIn(speed);
    } else {
      el.fadeOut(speed);
    };
    el.queue('fx', function() { el.dequeue(); });
    el.dequeue();
  });
};
})(jQuery);

