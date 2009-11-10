$(document).ready(function() {
    prepareList();
    prepareForm();
});

function prepareList() {
    $('a.newLink').live('click', function(e){
        content.spin().load($(this).attr('href'), function(){
            prepareForm();
            content.unspin();
        });
        return false;
    });

    $('a.editLink').live('click', function(e){
        content.spin().load($(this).attr('href'), function(){
            prepareForm();
            content.unspin();
        });
        return false;
    });

    $('a.showLink').live('click', showDetails);
    $('.dataList tbody tr td:not(:has(*))').live('click', showDetails);
}

function prepareForm() {
  $('#content form').validationEngine({
      success: function(){
         form = $('#content form');
         content.spin();
         $.post(form.attr('action'), form.serialize(), function(data){
            content.html(data).unspin();
            message.load(messagesPath, function(){content.unspin()});
         });
      }
  });

  showPrioritySlider();
  showEstimativeSlider();
  showColorInput();
}

function showPrioritySlider() {
    $('input#story_priority')
        .attr("readonly","readonly")
        .attr('tabindex', '')
        .after('<br/><span class="slider clearfix" id="priority-slider"></span>');
    $('span#priority-slider')
        .slider({min:0, max:100, value:$('input#story_priority').val(), slide:function(e,ui){$('input#story_priority').val(ui.value)}})
        .children('a')
        .attr('tabindex', '2');
}

function showEstimativeSlider() {
    $('input#story_estimative')
        .attr("readonly","readonly")
        .attr('tabindex', '')
        .after('<br/><span class="slider clearfix" id="estimative-slider"></span>');
    $('span#estimative-slider')
        .slider({min:0, max:100, value:$('input#story_estimative').val(), slide:function(e,ui){$('input#story_estimative').val(ui.value)}})
        .children('a')
        .attr('tabindex', '3');
}

function showColorInput() {
  $('input#story_color').ColorPicker({
    onChange: function (hsb, hex, rgb) {
		  $('input#story_color').val(hex).css('color', '#'+hex);
	  }
  });
}

function showDetails(e) {
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
    return false;
  });
}

