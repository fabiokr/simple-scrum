$(document).ready(function() {
  $('table#kanban tbody tr td div.name').click(showDetails);
});

function showDetails() {
  $('#inner-content').spin();

  var title = null;
  if($(this).parents('div.postit').hasClass('story')) {
    title = i18n.product_backlog_dialog_title;
  } else {
    title = i18n.sprint_backlog_task_dialog_title;
  }

  (i18n.sprint_backlog_task_dialog_title)
  $.get($(this).parent().find('a.showLink').attr('href'), function(data) {
    $.Spinner.unspin();
    $(data).dialog({
      title:title,
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

