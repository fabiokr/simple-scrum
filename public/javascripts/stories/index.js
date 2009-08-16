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

