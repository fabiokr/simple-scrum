$(document).ready(function() {
  $('.dataList tbody tr td:not(:has(*))').click(showDetails);
  $('.dataList tbody tr td a.showLink').click(showDetails);
});

function showDetails() {
  $('#content').spin();
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

