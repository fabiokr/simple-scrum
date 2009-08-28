$(document).ready(function() {
  addConfirmToDestoyForm();
  $("form.dataForm").validationEngine();

  //Test only
  $("body").addGrid({img_path: '/images/',margin:"1.5em auto"});
});

function addConfirmToDestoyForm() {
  $('table#dataList tbody tr td form.deleteLink').click(function() {
    return confirm(i18n.confirm_destroy);
  });
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

