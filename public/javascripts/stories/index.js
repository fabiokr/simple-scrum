$(document).ready(function() {
  addAjaxToNewButton();
  addAjaxToDataTable();
  $('table#dataList tbody tr').live('click', showPostit);
});

function showPostit() {
  $('#inner-content').spin();
  $.get($(this).find('a.showLink').attr('href'), function(data) {
    $.Spinner.unspin();
    $(data).dialog({
      title:i18n.product_backlog_dialog_title,
      modal:true,
      height:400,
      width:450,
      resizable:false,
      show:'fade',
      hide:'fade'
    });
  });
  return false;
}

function pageFormSpecifics() {
  showPrioritySlider();
  showEstimativeSlider();
}

var estimativeInput, estimativeSlider, priorityInput, prioritySlider;

function showPrioritySlider() {
  priorityInput = $('input#story_priority');
  priorityInput.addClass('notEditable').after('<br/><span class="slider clearfix" id="priority-slider"></span>');
  prioritySlider = $('span#priority-slider');
  prioritySlider.slider({min:0, max:100, value:priorityInput.val(), slide:function(e,ui){priorityInput.val(ui.value)}});
}

function showEstimativeSlider() {
  estimativeInput = $('input#story_estimative');
  estimativeInput.addClass('notEditable').after('<br/><span class="slider clearfix" id="estimative-slider"></span>');
  estimativeSlider = $('span#estimative-slider');
  estimativeSlider.slider({min:0, max:100, value:estimativeInput.val(), slide:function(e,ui){estimativeInput.val(ui.value)}});
}

