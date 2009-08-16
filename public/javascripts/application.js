$(document).ready(function() {
  //Test only
  $("body").addGrid({img_path: '/images/',margin:"1.5em auto"});
});

function addAjaxToNewButton() {
  $('a.newLink').live('click', function(){
    $('#inner-content').spin()
      .load($(this)
      .attr('href'), null, addAjaxToForm);
    return false;
  });
}

function addAjaxToDataTable() {
  //pagination ajax
  $('div.pagination a').live('click', function(){
    $('#inner-content').spin()
      .load($(this)
      .attr('href'), null, function(){
        $.Spinner.unspin();
      })
    return false;
  });

  //edit link ajax
  $('table#dataList tbody tr td a.editLink').live('click', function(){
    $('#inner-content').spin().load($(this).attr('href'), null, addAjaxToForm);
      return false;
  });

  //destroy link ajax
  $('table#dataList tbody tr td form.deleteLink').hide();
  $('table#dataList tbody tr td a.deleteLink').show().unbind().live('click', function() {
    if(confirm(i18n.confirm_destroy)) {
      $('#inner-content').spin();
      $(this).prev('form').ajaxSubmit({target:'#inner-content', success: function(){
        $('table#dataList tbody tr td form.deleteLink').hide();
        $('table#dataList tbody tr td a.deleteLink').show();
        $.Spinner.unspin();
      }});
    }
    return false;
  });
}

function addAjaxToForm() {
  $("[class^=validate]").validationEngine({
		success :  function() {
		  $('form.dataForm').ajaxSubmit({target:'#inner-content', success: addAjaxToForm});
		},
		failure : function() {}
	})
  $.Spinner.unspin();
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

