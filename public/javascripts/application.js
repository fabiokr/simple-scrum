//Globals
var messagesPath = '/messages', content, message, prepareListCallback, prepareFormCallback, showLinkCallback, destroyCallback, lastBreadcrumbCallback;

$(document).ready(function() {
  message = $('#message');
  content = $('#content');
  $('*[title]').inputHint();
  $('#breadcrumb a:last').click(function(){
    content.spin().load($(this).attr('href'), function(){
        message.html('');
        content.unspin();

        if(_.isFunction(lastBreadcrumbCallback)) {lastBreadcrumbCallback.call();}
    });
    return false;
  });
});

/*
    Interface for the default ajax behaviour.
    This will prepare the list and form ajax events.
    The options hash param support the following values:
    options['prepareList']: default is true; can be set to false if should not prepareList
    options['listCallback']: sets a callback function to be called after preparing the list
    options['formCallback']: sets a callback function to be called after preparing the form
    options['showLinkCallback']: sets a callback function to be called on the onclick event of showLink
    options['destroyCallback']: sets a callback function to be called on the onclick event of deleteLink
    options['lastBreadcrumbCallback']: sets a callback function to be called on the onclick event of the last breadcrumb
*/
function prepareAjax(options) {
    options = options || {};

    prepareListCallback = _.isUndefined(options['listCallback']) ? null : options['listCallback'];
    prepareFormCallback = _.isUndefined(options['formCallback']) ? null : options['formCallback'];
    showLinkCallback = _.isUndefined(options['showLinkCallback']) ? defaultShowLinkBehaviour : options['showLinkCallback'];
    destroyCallback = _.isUndefined(options['destroyCallback']) ? defaultDestroyBehaviour : options['destroyCallback'];
    lastBreadcrumbCallback = _.isUndefined(options['lastBreadcrumbCallback']) ? null : options['lastBreadcrumbCallback'];

    if(_.isUndefined(options['prepareList']) || options['prepareList']) {
        prepareList();
    }
}

//Sets ajax events for a data list
function prepareList() {
    $('a.newLink').live('click', function(e){
        content.spin().load($(this).attr('href'), function(){
            prepareForm(prepareFormCallback);
            message.load(messagesPath, function(){content.unspin()});
        });
        return false;
    });

    $('a.editLink').live('click', function(e){
        content.spin().load($(this).attr('href'), function(){
            prepareForm(prepareFormCallback);
            message.load(messagesPath, function(){content.unspin()});
        });
        return false;
    });

    $('a.showLink').live('click', showLinkCallback);
    $('.dataList tbody tr td:not(:has(*))').live('click', showLinkCallback);

    $('.deleteLink').live('click', destroyCallback);

    if(_.isFunction(prepareListCallback)) {prepareListCallback.call();}
}

//Sets ajax events for form
function prepareForm() {
  $('#content form').validationEngine({
      success: function(){
         form = $('#content form');
         content.spin();
         $.post(form.attr('action'), form.serialize(), function(data){
            content.html(data);
            message.load(messagesPath, function(){content.unspin()});
            prepareForm();
         });
      }
  });

  if(_.isFunction(prepareFormCallback)) {prepareFormCallback.call();}
}

function defaultShowLinkBehaviour(e) {
  content.spin();
  $.get($(this).parent().find('a.showLink').attr('href'), function(data) {
    $.Spinner.unspin();
    $(data).dialog({
      title:i18n.product_backlog_dialog_title,
      modal:true,
      height:500,
      width:710,
      resizable:false,
      show:'fade',
      hide:'fade'
    });
  });
  return false;
}

function defaultDestroyBehaviour() {
    if(confirm(i18n.confirm_destroy)) {
        form = $(this);
        content.spin();
        $.post(form.attr('action'), form.serialize(), function(data, status){
            if('success' == status) {
                content.load(location.href);
                message.load(messagesPath, function(){$.Spinner.unspin();});
            } else {
                content.html(data);
                message.load(messagesPath, function(){content.unspin()});
            }
        });
    }
    return false;
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

