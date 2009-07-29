$(document).ready(function() {
  $('a#new-button').click(function(){
    $('#inner-content').spin().load($(this).attr('href'), null, addAjaxToForm);
    return false;
  });
  $('table.dataList tbody tr').click(function() {
    $('#inner-content').spin().load($(this).find('a.editLink').attr('href'), null, addAjaxToForm);
    return false;
  });
});

function addAjaxToForm() {
  $('#inner-content').find('form').ajaxForm({target:'#inner-content', beforeSubmit: function(){$('#inner-content').find('form')}, success: addAjaxToForm});
  $.Spinner.unspin();
}

