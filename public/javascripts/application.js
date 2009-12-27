//Globals
var messagesPath = '/messages', content, message, prepareListCallback, prepareFormCallback, showLinkCallback, destroyCallback, lastBreadcrumbCallback;

$(document).ready(function() {
  message = $('#message');
  content = $('#content');
  $('*[title]').inputHint();
  $('#content form').validationEngine();
  $('.deleteLink').live('click', destroyLink);
});

function showDetailDialog(href) {
  content.spin();
  $.get(href, function(data) {
    $.Spinner.unspin();
    $(data).dialog({
      title:i18n.product_backlog_dialog_title,
      modal:true,
      height:450,
      width:600,
      resizable:false,
      show:'fade',
      hide:'fade'
    });
  });
}

function destroyLink() {
  return confirm(i18n.confirm_destroy);
}

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

