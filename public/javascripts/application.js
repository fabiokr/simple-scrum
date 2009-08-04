function addAjaxToPagination() {
  $('div.pagination a').live('click', function(){
    $('#inner-content').spin()
      .load($(this)
      .attr('href'), null, function(){
        $.Spinner.unspin();
      })
    return false;
  });
}

function addAjaxToForm() {
  $('#inner-content').find('form')
    .ajaxForm({target:'#inner-content', beforeSubmit: function(){
      $('#inner-content').find('form')}, success: addAjaxToForm
    }
  );
  $.Spinner.unspin();
}

function addAjaxToDataTable() {
  $('a#new-button').live('click', function(){
    $('#inner-content').spin()
      .load($(this)
      .attr('href'), null, addAjaxToForm);
    return false;
  });

  $('table#dataList tbody tr').live('click', function(){
    $('#inner-content').spin()
      .load($(this)
      .find('a.editLink')
      .attr('href'), null, addAjaxToForm);
    return false;
  });
}

