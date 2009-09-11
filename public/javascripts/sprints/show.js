$(document).ready(function() {
  $('table#kanban tbody tr td div.name').click(showDetails);
});

function showDetails() {
  $('#inner-content').spin();
  $.get($(this).parent().find('a.showLink').attr('href'), function(data) {
    $.Spinner.unspin();
    $(data).dialog({
      title:i18n.sprint_backlog_task_dialog_title,
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

